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

local modules = {
	{ import = "plugins.autopairs" },
	{ import = "plugins.alpha" },
	{ import = "plugins.bufferline" },
	{ import = "plugins.bracketed" },
	{ import = "plugins.comment" },
	{ import = "plugins.colorizer" },
	{ import = "plugins.copilot" },
	{ import = "plugins.conform" },
	{ import = "plugins.colorscheme" },
	{ import = "plugins.cmp" },
	{ import = "plugins.flash" },
	{ import = "plugins.fzf-lua" },
	{ import = "plugins.gitsigns" },
	{ import = "plugins.illuminate" },
	{ import = "plugins.just" },
	{ import = "plugins.mini" },
	{ import = "plugins.mason" },
	{ import = "plugins.multicursor" },
	{ import = "plugins.neotest" },
	{ import = "plugins.neo_tree" },
	{ import = "plugins.nvim_dap" },
	{ import = "plugins.noice" },
	{ import = "plugins.nvim_notify" },
	{ import = "plugins.nvim_treesitter" },
	{ import = "plugins.nvim_lint" },
	{ import = "plugins.lazy" },
	{ import = "plugins.lualine" },
	{ import = "plugins.lsp" },
	{ import = "plugins.lsp_saga" },
	{ import = "plugins.lazygit" },
	{ import = "plugins.markdown" },
	{ import = "plugins.ui" },
	{ import = "plugins.todo_comments" },
	{ import = "plugins.trouble" },
	{ import = "plugins.spectre" },
	{ import = "plugins.rest" },
	{ import = "plugins.refactoring" },
	{ import = "plugins.vim_dadbod" },
	{ import = "plugins.vim_startuptime" },
	{ import = "plugins.yanky" },
}

return require("lazy").setup(modules)
