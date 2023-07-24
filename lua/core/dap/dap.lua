local status_ok, dap = pcall(require, "dap")

if not status_ok then
	return
end
--
vim.g.dap_virtual_text = true

-- Icon's
--
vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

-- Keybindings
--
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<Leader>dt", "<CMD>lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<Leader>dc", "<CMD>lua require('dap').continue()<CR>", opts)
keymap("n", "<Leader>dC", "<CMD>lua require('dap').run_to_cursor()<CR>", opts)
keymap("n", "<Leader>db", "<CMD>lua require('dap').step_back()<CR>", opts)
keymap("n", "<Leader>dd", "<CMD>lua require('dap').disconnect()<CR>", opts)
keymap("n", "<Leader>dh", "<CMD>lua require('dapui').eval()<CR>", opts)
keymap("n", "<Leader>di", "<CMD>lua require('dap').step_into()<CR>", opts)
keymap("n", "<Leader>do", "<CMD>lua require('dap').step_out()<CR>", opts)
keymap("n", "<Leader>dO", "<CMD>lua require('dap').step_over()<CR>", opts)
keymap("n", "<Leader>dp", "<CMD>lua require('dap').pause()<CR>", opts)
keymap("n", "<Leader>dr", "<CMD>lua require('dap').repl.toggle()<CR>", opts)
keymap("n", "<Leader>dq", "<CMD>lua require('dap').close()<CR>", opts)
keymap("n", "<Leader>dQ", "<CMD>lua require('dap').terminate()<CR>", opts)

-- NODE / TYPESCRIPT
--
dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

-- Chrome
dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
}

-- Configurations

dap.configurations.javascript = {
	{
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
}

dap.configurations.javascript = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.javascriptreact = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.typescriptreact = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}
