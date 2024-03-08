local status_ok, indentBlankLine = pcall(require, "indent_blankline")

if not status_ok then
	return
end

vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#44475A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#44475A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#44475A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#44475A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#44475A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#44475A  gui=nocombine]]
vim.cmd[[highlight IndentBlanklineContextChar guifg=#BD93F9 gui=nocombine]]

local opts = {
	filetype_exclude = {
		"help",
		"alpha",
		"dashboard",
		"NvimTree",
		"mason",
		"toggleterm",
	},
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	space_char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	show_trailing_blankline_indent = true,
	show_end_of_line = false,
}

-- indentBlankLine.setup(opts)
