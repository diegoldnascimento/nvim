return {
	{
		"nvimdev/lspsaga.nvim",
		keys = {
			{
				"gD",
				"<cmd>Lspsaga goto_definition<CR>",
				mode = { "n", "v" },
				desc = "Go to definition",
			},
			{
				"gr",
				"<cmd>Lspsaga finder<CR>",
				mode = { "n", "v" },
				desc = "Show references",
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
				"[d",
				function()
					require("lspsaga.diagnostic"):goto_prev()
				end,
				mode = { "n", "v" },
				desc = "Go to previous error diagnostic",
			},
			{
				"]d",
				function()
					require("lspsaga.diagnostic"):goto_next()
				end,
				mode = { "n", "v" },
				desc = "Go to next error diagnostic",
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
				"gk",
				function()
					vim.lsp.buf.signature_help()
				end,
				mode = { "n", "v" },
				desc = "Show hover documentation",
			},
			{
				"gx",
				"<cmd>Lspsaga show_workspace_diagnostics<CR>",
				mode = { "n", "v" },
				desc = "Show workspace diagnostics",
			},
		},
		opts = {
			show_code_action = true,
			scroll_preview = {
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
			finder = {
				keymaps = {
					quit = "q",
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
				virtual_text = true,
			},
		},
		config = function(_, opts)
			require("lspsaga").setup(opts)
		end,
	},
}
