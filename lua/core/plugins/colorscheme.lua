return {
	-- {
	-- 	dir = "~/Dev/diegolopes/illusion.nvim",
	-- 	name = "catppuccin",
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			integrations = {
	-- 				cmp = true,
	-- 				gitsigns = true,
	-- 				nvimtree = true,
	-- 				treesitter = true,
	-- 				notify = false,
	-- 				mini = false,
	-- 			},
	-- 		})
	--
	-- 		require("dracula").setup({
	-- 			colors = {
	-- 				bg = "#1E1D22",
	-- 				fg = "#F8F8F2",
	-- 				selection = "#44475A",
	-- 				comment = "#5f5076",
	-- 				red = "#FF5555",
	-- 				orange = "#FFB86C",
	-- 				yellow = "#F1FA8C",
	-- 				green = "#04f1aa",
	-- 				purple = "#d09cfc",
	-- 				cyan = "#8BE9FD",
	-- 				pink = "#FF79C6",
	-- 				bright_red = "#FF6E6E",
	-- 				bright_green = "#69FF94",
	-- 				bright_yellow = "#FFFFA5",
	-- 				bright_blue = "#D6ACFF",
	-- 				bright_magenta = "#FF92DF",
	-- 				bright_cyan = "#A4FFFF",
	-- 				bright_white = "#FFFFFF",
	-- 				menu = "#1E1D22",
	-- 				visual = "#3E4452",
	-- 				gutter_fg = "#4B5263",
	-- 				nontext = "#3B4048",
	-- 			},
	-- 			show_end_of_buffer = true,
	-- 			transparent_bg = true,
	-- 			italic_comment = true,
	-- 			overrides = {},
	-- 		})
	--
	-- 		-- vim.cmd([[colorscheme catppuccin]])
	-- 		vim.cmd([[colorscheme dracula]])
	-- 	end,
	-- }{
	{ "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
}
