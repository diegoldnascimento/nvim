local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local modules = {
	{ import = "core.plugins.autopairs" },
	{ import = "core.plugins.alpha" },
	{ import = "core.plugins.bufferline" },
	{ import = "core.plugins.comment" },
	{ import = "core.plugins.colorscheme" },
	{ import = "core.plugins.completion" },
	{ import = "core.plugins.copilot" },
	{ import = "core.plugins.debug" },
	{ import = "core.plugins.flash" },
	{ import = "core.plugins.formatter" },
  { import = "core.plugins.illuminate" },
	{ import = "core.plugins.nvim_tree" },
	{ import = "core.plugins.nvim_notify" },
	{ import = "core.plugins.nvim_treesitter" },
	{ import = "core.plugins.nvim_lint" },
	{ import = "core.plugins.lualine" },
	{ import = "core.plugins.lsp" },
	{ import = "core.plugins.markdown" },
	{ import = "core.plugins.test" },
	{ import = "core.plugins.ui" },
	{ import = "core.plugins.telescope" },
	{ import = "core.plugins.trouble" },
	{ import = "core.plugins.spectre" },
	{ import = "core.plugins.mini" },
}

return require("lazy").setup(modules)
