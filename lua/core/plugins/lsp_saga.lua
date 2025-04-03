return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		keys = {
			{
				"gd",
				"<cmd>Lspsaga goto_definition<CR>",
				mode = { "n", "v" },
				desc = "Go to definition",
			},
			{
				"<leader>ca",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "Trigger Code Action",
			},
			{
				"gr",
				"<cmd>Lspsaga finder def+ref+imp<CR>",
				mode = { "n", "v" },
				desc = "Show references, definitions, and implementations",
			},
			{
				"[e",
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				mode = { "n", "v" },
				desc = "Go to previous error diagnostic",
			},
			{
				"]e",
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				mode = { "n", "v" },
				desc = "Go to next error diagnostic",
			},

			{
				"[w",
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARNING })
				end,
				mode = { "n", "v" },
				desc = "Go to previous warning diagnostic",
			},
			{
				"]w",
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARNING })
				end,
				mode = { "n", "v" },
				desc = "Go to next warning diagnostic",
			},
			{
				"[d",
				function()
					require("lspsaga.diagnostic"):goto_prev()
				end,
				mode = { "n", "v" },
				desc = "Go to previous diagnostic",
			},
			{
				"]d",
				function()
					require("lspsaga.diagnostic"):goto_next()
				end,
				mode = { "n", "v" },
				desc = "Go to next diagnostic",
			},
			{
				"ga",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "Show code actions preview",
			},
			{
				"K",
				"<cmd>Lspsaga hover_doc<CR>",
				mode = { "n", "v" },
				desc = "Show hover documentation",
			},
			{
				"gx",
				"<cmd>Lspsaga show_workspace_diagnostics<CR>",
				mode = { "n", "v" },
				desc = "Show workspace diagnostics",
			},
			{
				"X",
				"<cmd>Lspsaga show_line_diagnostics<CR>",
				mode = { "n", "v" },
				desc = "Show line diagnostics",
			},
			{
				"<leader>cs",
				"<cmd>Lspsaga outline<CR>",
				mode = { "n", "v" },
				desc = "A code outline window for skimming and quick navigation",
			},
		},
		cmd = "Lspsaga",
		opts = {
			show_code_action = true,
			scroll_preview = {
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
			finder = {
				keymaps = {
					quit = "q",
					vsplit = "v",
					split = "s",
					close = "<ESC>",
					toggle_or_open = "o",
				},
			},
			definition = {
				keymaps = {
					quit = "q",
				},
			},
			diagnostic = {
				keys = {
					quit = { "q", "<ESC>" },
				},
			},
			code_action = {
				keys = {
					quit = { "q", "<ESC>" },
				},
			},
			lightbulb = {
				enable = true,
				enable_in_insert = true,
				sign = true,
				sign_priority = 40,
				virtual_text = false,
			},
		},
	},
}
