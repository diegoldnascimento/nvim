return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.api.nvim_command, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
		init = function()
			local lsp = require("lsp-zero").preset({})

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)
			lsp.setup()
		end,
	},
}
