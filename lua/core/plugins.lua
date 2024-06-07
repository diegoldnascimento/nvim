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
	{ import = "core.plugins.autopairs" },
	{ import = "core.plugins.alpha" },
	{ import = "core.plugins.bufferline" },
	{ import = "core.plugins.comment" },
	{ import = "core.plugins.colorizer" },
	{ import = "core.plugins.copilot" },
	{ import = "core.plugins.conform" },
	{ import = "core.plugins.colorscheme" },
	{ import = "core.plugins.cmp" },
	{ import = "core.plugins.flash" },
	{ import = "core.plugins.gitsigns" },
	{ import = "core.plugins.illuminate" },
	{ import = "core.plugins.import-cost" },
	{ import = "core.plugins.mini" },
	{ import = "core.plugins.mason" },
	{ import = "core.plugins.neotest" },
	{ import = "core.plugins.neo_tree" },
	{ import = "core.plugins.nvim_dap" },
	{ import = "core.plugins.noice" },
	{ import = "core.plugins.nvim_notify" },
	{ import = "core.plugins.nvim_treesitter" },
	{ import = "core.plugins.nvim_lint" },
	{ import = "core.plugins.lualine" },
	{ import = "core.plugins.lsp" },
	{ import = "core.plugins.lazygit" },
	{ import = "core.plugins.lsp_saga" },
	{ import = "core.plugins.markdown" },
	{ import = "core.plugins.oil" },
	{ import = "core.plugins.ui" },
	{ import = "core.plugins.telescope" },
	{ import = "core.plugins.todo_comments" },
	{ import = "core.plugins.trouble" },
	{ import = "core.plugins.spectre" },
	{ import = "core.plugins.rest" },
	{ import = "core.plugins.nvim_tmux_navigator" },
	{ import = "core.plugins.vim_dadbod" },
}

return require("lazy").setup(modules)
