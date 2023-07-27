return {
	{ "folke/lazy.nvim" },
	{ "goolord/alpha-nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "windwp/nvim-autopairs", event = "VeryLazy" },
	{ "lewis6991/gitsigns.nvim", event = "VeryLazy" },
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{ "ahmedkhalf/project.nvim", event = "VeryLazy" },
	{ "folke/which-key.nvim", event = "VeryLazy" },
	{ "folke/trouble.nvim", event = "VeryLazy" },
	{ "RRethy/vim-illuminate", event = "VeryLazy", priority = 1 },
	{ "APZelos/blamer.nvim", event = "VeryLazy" },
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "p00f/nvim-ts-rainbow" },
	{ "max397574/better-escape.nvim", name = "better_escape", event = "VeryLazy" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = false,
				command_palette = false,
				long_message_to_split = true,
				inc_rename = true,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				background_colour = "#1E1D22",
			})
		end,
	},
}
