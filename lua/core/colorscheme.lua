local status_ok, rosepine = pcall(require, "rose-pine")

if not status_ok then
	return
end

vim.opt.termguicolors = true

-- setup must be called before loading
vim.cmd("colorscheme rose-pine")
