local status_ok, dracula = pcall(require, "dracula")

if not status_ok then
	return
end

-- Illusion Refined theme
--
--

-- "#1E1D22",
--      "#1F1F23",
--      "#F8F8F2",
--      "#44475A",
--      "#5F5076",
--      "#C53788",
--      "#8BE9FD",
--      "#50FA7B",
--      "#FFB86C",
--      "#FF79C6",
--      "#BD93F9",
--      "#FF5555",
--      "#F1FA8C"

-- Using the Dracula base and creating the Illusion theme colorscheme
-- https://github.com/rwietter/illusion-vscode-theme
vim.opt.termguicolors = true

dracula.setup({
	colors = {
		bg = "#1E1D22",
		fg = "#F8F8F2",
		selection = "#44475A",
		comment = "#5f5076",
		red = "#FF5555",
		orange = "#FFB86C",
		yellow = "#F1FA8C",
		green = "#04f1aa",
		purple = "#d09cfc",
		cyan = "#8BE9FD",
		pink = "#FF79C6",
		bright_red = "#FF6E6E",
		bright_green = "#69FF94",
		bright_yellow = "#FFFFA5",
		bright_blue = "#D6ACFF",
		bright_magenta = "#FF92DF",
		bright_cyan = "#A4FFFF",
		bright_white = "#FFFFFF",
		menu = "#1E1D22",
		visual = "#3E4452",
		gutter_fg = "#4B5263",
		nontext = "#3B4048",
	},
	show_end_of_buffer = false,
	transparent_bg = true,
	italic_comment = true,
	overrides = {},
})

vim.cmd([[colorscheme dracula]])
