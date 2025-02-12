return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},

		keys = {
			{
				"gi",
				function()
					vim.lsp.buf.implementation()
				end,
				mode = { "n", "v" },
				desc = "Go to implementation",
			},
			{
				"X",
				function()
					vim.diagnostic.open_float(0, { scope = "line" })
				end,
				mode = { "n", "v" },
				desc = "Show line diagnostics",
			},
			{
				"gr",
				function()
					vim.lsp.buf.references()
				end,
				mode = { "n", "v" },
				desc = "Show references",
			},
			{
				"[e",
				function()
					vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				mode = { "n", "v" },
				desc = "Go to previous error diagnostic",
			},
			{
				"]e",
				function()
					vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				mode = { "n", "v" },
				desc = "Go to next error diagnostic",
			},
			{
				"[w",
				function()
					vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
				end,
				mode = { "n", "v" },
				desc = "Go to previous warning diagnostic",
			},
			{
				"]w",
				function()
					vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
				end,
				mode = { "n", "v" },
				desc = "Go to next warning diagnostic",
			},
			{
				"[d",
				function()
					vim.diagnostic.goto_prev()
				end,
				mode = { "n", "v" },
				desc = "Go to previous diagnostic",
			},
			{
				"]d",
				function()
					vim.diagnostic.goto_next()
				end,
				mode = { "n", "v" },
				desc = "Go to next diagnostic",
			},
			{
				"K",
				function()
					vim.lsp.buf.hover()
				end,
				mode = { "n", "v" },
				desc = "Show hover documentation",
			},
			{
				"gx",
				function()
					vim.diagnostic.setqflist()
				end,
				mode = { "n", "v" },
				desc = "Show workspace diagnostics",
			},
			{
				"<leader>cs",
				function()
					vim.lsp.buf.document_symbol()
				end,
				mode = { "n", "v" },
				desc = "Show document symbols",
			},
		},
		init = function()
			local lsp_zero = require("lsp-zero").preset("recommended")

			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			lsp_zero.setup()
		end,
	},
}
