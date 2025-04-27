return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true

			require("dracula").setup({
				colors = {
					bg = "#1E1D22",
					fg = "#F8F8F2",
					menu = "#1E1D22",
					visual = "#3E4452",
					gutter_fg = "#4B5263",
					nontext = "#3B4048",
					selection = "#44475A",
					bright_white = "#FFFFFF",
					white = "#ABB2BF",
					black = "#191A21",
				},
				show_end_of_buffer = true,
				transparent_bg = true,
				italic_comment = true,
				overrides = {},
			})

			vim.cmd([[colorscheme dracula-soft]])
		end,
	},
	-- {
	-- 	"forest-nvim/sequoia.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme sequoia-night") -- or 'sequoia-night' / 'sequoia-rise'
	-- 	end,
	-- },
}
