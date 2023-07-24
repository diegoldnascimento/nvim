return {
	{ "hrsh7th/nvim-cmp", event = "VeryLazy" },
	{ "hrsh7th/cmp-path", event = "VeryLazy" },
	{ "saadparwaiz1/cmp_luasnip", event = "VeryLazy" },
	{ "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
	{ "hrsh7th/cmp-nvim-lua", event = "VeryLazy" },
	{ "hrsh7th/cmp-cmdline", event = "VeryLazy" },
	{ "hrsh7th/cmp-buffer", event = "VeryLazy" },
	{ "onsails/lspkind.nvim", event = "VeryLazy" },
	{ "zbirenbaum/copilot.lua", event = "VeryLazy", build = ":Copilot auth" },
	{
		"zbirenbaum/copilot-cmp",
		event = "VeryLazy",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{ "L3MON4D3/LuaSnip", event = "VeryLazy" },
	{ "rafamadriz/friendly-snippets", event = "VeryLazy" },
	{ "mlaursen/vim-react-snippets", event = "VeryLazy" },
}
