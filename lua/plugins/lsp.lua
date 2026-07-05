return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "K", vim.lsp.buf.hover, desc = "Hover documentation" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
			{ "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
			{ "gr", vim.lsp.buf.references, desc = "Go to references" },
			{ "gy", vim.lsp.buf.type_definition, desc = "Go to type definition" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
			{ "<leader>cl", vim.lsp.codelens.run, desc = "Run codelens" },
			{ "gx", vim.diagnostic.setqflist, desc = "Workspace diagnostics" },
			{ "gl", vim.diagnostic.open_float, desc = "Line diagnostics" },
			{ "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Prev diagnostic" },
			{ "<leader>ci", "<cmd>LspInfo<cr>", desc = "LSP info" },
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local uv = vim.uv
			local ts_client_names = {
				tsgo = true,
				vtsls = true,
				["typescript-tools"] = true,
				ts_ls = true,
			}
			local tsgo_pid_dir = vim.fs.joinpath(vim.fn.stdpath("state"), "tsgo-pids")
			local tsgo_wrapper_path = vim.fs.joinpath(vim.fn.stdpath("state"), "tsgo-pid-wrapper.sh")

			local function ensure_tsgo_wrapper()
				vim.fn.mkdir(tsgo_pid_dir, "p")
				if vim.fn.filereadable(tsgo_wrapper_path) == 1 then
					return tsgo_wrapper_path
				end

				vim.fn.writefile({
					"#!/bin/sh",
					'pidfile="$1"',
					"shift",
					'mkdir -p "$(dirname "$pidfile")"',
					'printf "%s\\n" "$$" > "$pidfile"',
					'exec "$@"',
				}, tsgo_wrapper_path)
				vim.fn.setfperm(tsgo_wrapper_path, "rwxr-xr-x")
				return tsgo_wrapper_path
			end

			local function tsgo_pid_file(root_dir)
				local key = root_dir or vim.fn.getcwd()
				local hash = vim.fn.sha256(key)
				return vim.fs.joinpath(tsgo_pid_dir, hash .. ".pid")
			end

			local function get_current_ts_client(bufnr)
				for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
					if ts_client_names[client.name] then
						return client
					end
				end
			end

			-- Configuração global para todos os LSPs
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				root_markers = {
					".emmyrc.json",
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					".git",
				},
			})

			vim.lsp.config("tsgo", {
				cmd = function(dispatchers, config)
					local base_cmd = "tsgo"
					local cmd
					if (config or {}).root_dir then
						local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", base_cmd)
						if vim.fn.executable(local_cmd) == 1 then
							cmd = local_cmd
						end
					end

					if not cmd then
						local mason_cmd = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin", "tsgo")
						if vim.fn.executable(mason_cmd) == 1 then
							cmd = mason_cmd
						else
							cmd = base_cmd
						end
					end

					local pidfile = tsgo_pid_file((config or {}).root_dir)
					local wrapper = ensure_tsgo_wrapper()
					return vim.lsp.rpc.start({ wrapper, pidfile, cmd, "--lsp", "--stdio" }, dispatchers)
				end,
				settings = {
					typescript = {
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
				},
			})

			vim.lsp.enable("tsgo")

			vim.api.nvim_create_user_command("LspMemoryUsage", function()
				local bufnr = vim.api.nvim_get_current_buf()
				local client = get_current_ts_client(bufnr)

				if not client then
					vim.notify("No TypeScript LSP client attached to the current buffer", vim.log.levels.WARN)
					return
				end

				if client.name == "tsgo" then
					local pidfile = tsgo_pid_file(client.config and client.config.root_dir)
					if vim.fn.filereadable(pidfile) == 0 then
						vim.notify("No tsgo PID file found for the current workspace", vim.log.levels.WARN)
						return
					end

					local pid = vim.trim(table.concat(vim.fn.readfile(pidfile), "\n"))
					if pid == "" then
						vim.notify("tsgo PID file is empty for the current workspace", vim.log.levels.WARN)
						return
					end

					local ps = vim.system({ "ps", "-p", pid, "-o", "rss=,command=" }, { text = true }):wait()
					if ps.code ~= 0 then
						vim.notify(("Unable to inspect tsgo process %s"):format(pid), vim.log.levels.WARN)
						return
					end

					local line = vim.trim(ps.stdout or "")
					local rss_kb, command = line:match("^(%d+)%s+(.+)$")
					if not rss_kb or not command then
						vim.notify(("Unexpected ps output for tsgo process %s: %s"):format(pid, line), vim.log.levels.WARN)
						return
					end

					local mem_mb = tonumber(rss_kb) / 1024
					vim.notify(
						table.concat({
							"PID  MEM(MB)  COMMAND",
							"---  -------  -------",
							string.format("%s  %.0f  %s", pid, mem_mb, command),
						}, "\n"),
						vim.log.levels.INFO
					)
					return
				end

				vim.notify(
					("Memory usage lookup is only implemented for server-specific clients and is unavailable for %s"):format(
						client.name
					),
					vim.log.levels.WARN
				)
			end, { desc = "Show TS server memory usage when supported" })

			-- Keybinds específicos do tsgo
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or client.name ~= "tsgo" then
						return
					end

					local buf = args.buf
					local function ts_action(action)
						return function()
							vim.lsp.buf.code_action({
								apply = true,
								context = { only = { action }, diagnostics = {} },
							})
						end
					end

					local ts_keys = {
						{ "<leader>co", ts_action("source.organizeImports"), "Organize imports" },
						{ "<leader>cM", ts_action("source.addMissingImports"), "Add missing imports" },
						{ "<leader>cu", ts_action("source.removeUnused"), "Remove unused" },
						{ "<leader>cD", ts_action("source.fixAll"), "Fix all" },
					}

					for _, key in ipairs(ts_keys) do
						vim.keymap.set("n", key[1], key[2], { buffer = buf, desc = key[3] })
					end

					-- Code action picker com fzf-lua
					vim.keymap.set("n", "<leader>cf", function()
						local actions = {
							{ "Organize Imports", "source.organizeImports" },
							{ "Add Missing Imports", "source.addMissingImports" },
							{ "Remove Unused", "source.removeUnused" },
							{ "Fix All", "source.fixAll" },
							{ "Extract Function", "refactor.extract.function" },
							{ "Extract Variable", "refactor.extract.constant" },
						}

						require("fzf-lua").fzf_exec(
							vim.tbl_map(function(a)
								return a[1]
							end, actions),
							{
								prompt = "TS Actions> ",
								actions = {
									["default"] = function(selected)
										for _, a in ipairs(actions) do
											if a[1] == selected[1] then
												ts_action(a[2])()
												return
											end
										end
									end,
								},
							}
						)
					end, { buffer = buf, desc = "TS code actions" })
				end,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or client.name ~= "tsgo" then
						return
					end

					local remaining = vim.lsp.get_clients({ name = "tsgo" })
					if #remaining <= 1 then
						local pidfile = tsgo_pid_file(client.config and client.config.root_dir)
						if uv.fs_stat(pidfile) then
							uv.fs_unlink(pidfile)
						end
					end
				end,
			})
		end,
	},

	-- Instala tsgo via mason-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"tsgo",
			},
		},
		init = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
}
