---@diagnostic disable: undefined-field
local async = require("neotest.async")
local lib = require("neotest.lib")
local logger = require("neotest.logging")
local util = require("neotest-vitest.util")

---@class neotest.BunOptions
---@field bunCommand? string|fun(): string
---@field env? table<string, string>|fun(): table<string, string>
---@field cwd? string|fun(): string
---@field filter_dir? fun(name: string, relpath: string, root: string): boolean
---@field is_test_file? fun(file_path: string): boolean

---@class neotest.Adapter
local adapter = { name = "neotest-bun" }

local function getEnv(specEnv)
	return specEnv
end

local function printTable(tbl, indent)
	indent = indent or 0
	local formatting = string.rep("  ", indent)

	if type(tbl) ~= "table" then
		print(formatting .. tostring(tbl))
		return
	end

	print(formatting .. "{")
	for key, value in pairs(tbl) do
		local formattedKey = (type(key) == "string") and ('"' .. key .. '"') or tostring(key)

		if type(value) == "table" then
			print(formatting .. "  [" .. formattedKey .. "] = {")
			printTable(value, indent + 1)
			print(formatting .. "  },") -- Close table at the correct indentation level
		else
			local formattedValue = (type(value) == "string") and ('"' .. value .. '"') or tostring(value)
			print(formatting .. "  [" .. formattedKey .. "] = " .. formattedValue .. ",")
		end
	end
	print(formatting .. "}")
end

local function get_strategy_config(strategy, command, cwd)
	local config = {
		dap = function()
			return {
				name = "Debug Vitest Tests",
				type = "pwa-node",
				request = "launch",
				args = { unpack(command, 2) },
				runtimeExecutable = command[1],
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
				cwd = cwd or "${workspaceFolder}",
			}
		end,
	}
	if config[strategy] then
		return config[strategy]()
	end
end

local rootPackageJson = vim.fn.getcwd() .. "/package.json"

---@param packageJsonContent string
---@return boolean
local function hasBunDependencyInJson(packageJsonContent)
	return true
	-- local parsedPackageJson = vim.json.decode(packageJsonContent)
	-- for _, dependencyType in ipairs({ "dependencies", "devDependencies" }) do
	-- 	if parsedPackageJson[dependencyType] then
	-- 		for key, _ in pairs(parsedPackageJson[dependencyType]) do
	-- 			if key == "bun" then
	-- 				return true
	-- 			end
	-- 		end
	-- 	end
	-- end
	-- return false
end

---@return boolean
local function hasRootProjectBunDependency()
	local success, packageJsonContent = pcall(lib.files.read, rootPackageJson)
	if not success then
		print("cannot read package.json")
		return false
	end
	return hasBunDependencyInJson(packageJsonContent)
end

---@param path string
---@return boolean
local function hasBunDependency(path)
	return true
	-- local rootPath = lib.files.match_root_pattern("package.json")(path)
	-- if not rootPath then
	-- 	return false
	-- end
	-- local success, packageJsonContent = pcall(lib.files.read, rootPath .. "/package.json")
	-- if not success then
	-- 	print("cannot read package.json")
	-- 	return false
	-- end
	-- return hasBunDependencyInJson(packageJsonContent) or hasRootProjectBunDependency()
end

adapter.root = function(path)
	return lib.files.match_root_pattern("package.json")(path)
end

function adapter.filter_dir(name, _relpath, _root)
	return name ~= "node_modules"
end

---@param file_path? string
---@return boolean
function adapter.is_test_file(file_path)
	if file_path == nil then
		return false
	end
	local is_test_file = false
	if string.match(file_path, "__tests__") then
		is_test_file = true
	end
	for _, x in ipairs({ "spec", "test" }) do
		for _, ext in ipairs({ "js", "jsx", "coffee", "ts", "tsx" }) do
			if string.match(file_path, "%." .. x .. "%." .. ext .. "$") then
				is_test_file = true
				goto matched_pattern
			end
		end
	end
	::matched_pattern::
	return is_test_file and hasBunDependency(file_path)
end

local function getCwd(filePath)
	-- Remove the file name and keep the directory
	local cwd = filePath:match("(.*/)")
	return cwd or "." -- Return "." if no directory found (e.g., file is in current directory)
end

---@async
---@param path string
---@return neotest.Tree | nil
function adapter.discover_positions(path)
	-- Tree-sitter queries remain the same for discovering test files.
	local query = [[...]]
	query = query .. string.gsub(query, "arrow_function", "function_expression")
	return lib.treesitter.parse_positions(path, query, { nested_tests = true })
end

---@param path string
---@return string
local function getBunCommand(path)
	return "bun"
end

---@param args neotest.RunArgs
---@return neotest.RunSpec | nil
function adapter.build_spec(args)
	local results_path = async.fn.tempname() .. ".json"
	local tree = args.tree

	if not tree then
		return
	end
	local names = {}
	while tree and tree:data().type ~= "file" do
		table.insert(names, 1, tree:data().name)
		tree = tree:parent() --[[@as neotest.Tree]]
	end
	local testNamePattern = table.concat(names, " ")

	if #testNamePattern == 0 then
		testNamePattern = ".*"
	else
		testNamePattern = "^\\s?" .. escapeTestPattern(testNamePattern)
	end

	local pos = args.tree:data()
	if pos.type == "test" then
		testNamePattern = testNamePattern .. "$"
	end

	local binary = args.bunCommand or getBunCommand(pos.path)
	local command = vim.split(binary, "%s+")
	table.insert(command, "test")
	vim.list_extend(command, {
    -- TODO: Bun does not support reporter JSON yet
		"--reporter=json",
    -- TODO: It does not support the output file yet
		"--outputFile=" .. results_path,
		"--test-name-pattern " .. testNamePattern,
		"--rerun-each 1",
		vim.fs.normalize(pos.path),
	})

	local cwd = getCwd(pos.path)

	lib.files.write(results_path, "")
	local stream_data, stop_stream = util.stream(results_path)

	return {
		command = command,
		cwd = cwd,
		context = {
			results_path = results_path,
			file = pos.path,
			stop_stream = stop_stream,
		},
		stream = function()
			return function()
				local new_results = stream_data()

				if not new_results or new_results == "" then
          print("opa not")
					return {}
				end
				local ok, parsed = pcall(vim.json.decode, new_results, { luanil = { object = true } })
				if not ok or not parsed.testResults then
					return {}
				end
				return util.parsed_json_to_results(parsed, results_path, nil)
			end
		end,
		strategy = get_strategy_config(args.strategy, command, cwd),
		env = getEnv(args[2] and args[2].env or {}),
	}
end

---@async
---@param spec neotest.RunSpec
---@return neotest.Result[]
function adapter.results(spec, b, tree)
	spec.context.stop_stream()

	local output_file = spec.context.results_path

	local success, data = pcall(lib.files.read, output_file)

	if not success then
		logger.error("No test output file found ", output_file)
		return {}
	end

	local ok, parsed = pcall(vim.json.decode, data, { luanil = { object = true } })

	if not ok then
		logger.error("Failed to parse test output json ", output_file)
		return {}
	end

	local results = util.parsed_json_to_results(parsed, output_file, b.output)

	return results
end

local is_callable = function(obj)
	return type(obj) == "function" or (type(obj) == "table" and obj.__call)
end

setmetatable(adapter, {
	---@param opts neotest.VitestOptions
	__call = function(_, opts)
		-- if is_callable(opts.vitestCommand) then
		-- 	getBunCommand = opts.getBunCommand
		-- elseif opts.vitestCommand then
		-- 	getVitestCommand = function()
		-- 		return opts.vitestCommand
		-- 	end
		-- end
		--
		-- if is_callable(opts.vitestConfigFile) then
		-- 	getVitestConfig = opts.vitestConfigFile
		-- elseif opts.vitestConfigFile then
		-- 	getVitestConfig = function()
		-- 		return opts.vitestConfigFile
		-- 	end
		-- end

		if is_callable(opts.env) then
			getEnv = opts.env
		elseif opts.env then
			getEnv = function(specEnv)
				return vim.tbl_extend("force", opts.env, specEnv)
			end
		end

		if is_callable(opts.cwd) then
			getCwd = opts.cwd
		elseif opts.cwd then
			getCwd = function()
				return opts.cwd
			end
		end

		if is_callable(opts.filter_dir) then
			adapter.filter_dir = opts.filter_dir
		end

		if is_callable(opts.is_test_file) then
			adapter.is_test_file = function(file_path)
				return hasBunDependency(file_path) and opts.is_test_file(file_path)
			end
		end

		return adapter
	end,
})

return adapter

-- rest of the code remains the same, ensuring configuration flexibility for Bun
