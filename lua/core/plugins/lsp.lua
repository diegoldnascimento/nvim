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
