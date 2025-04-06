return {
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	-- { "folke/which-key.nvim", event = "VeryLazy" },
	{ "APZelos/blamer.nvim", event = "VeryLazy" },
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "max397574/better-escape.nvim", name = "better_escape", event = "VeryLazy" },
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
