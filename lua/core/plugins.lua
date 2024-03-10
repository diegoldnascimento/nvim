local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local modules = {
	{ import = "core.plugins.bufferline" },
	{ import = "core.plugins.comment" },
	{ import = "core.plugins.colorscheme" },
	{ import = "core.plugins.completion" },
	{ import = "core.plugins.copilot" },
	{ import = "core.plugins.debug" },
	{ import = "core.plugins.diagnostics" },
	{ import = "core.plugins.filetree" },
	{ import = "core.plugins.formatter" },
	{ import = "core.plugins.linter" },
	{ import = "core.plugins.lualine" },
	{ import = "core.plugins.lsp" },
	{ import = "core.plugins.markdown" },
	{ import = "core.plugins.motion" },
	{ import = "core.plugins.test" },
	{ import = "core.plugins.treesitter" },
	{ import = "core.plugins.ui" },
	{ import = "core.plugins.telescope" },
	{ import = "core.plugins.spectre" },
  { import = "core.plugins.mini" },
  { import = "core.plugins.autopairs" },
  { import = "core.plugins.notify" },
}

return require("lazy").setup(modules)
