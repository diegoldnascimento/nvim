return {
	{ "folke/lazy.nvim" },
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	-- { "folke/which-key.nvim", event = "VeryLazy" },
	{ "APZelos/blamer.nvim", event = "VeryLazy" },
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	-- {
	-- 	"mg979/vim-visual-multi",
	-- 	event = "VeryLazy",
	-- 	init = function()
	-- 		vim.api.nvim_exec(
	-- 			[[
	--          let g:VM_maps = {}
	--          let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
	--          let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
	--          let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'      " start selecting down
	--          let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'        " start selecting up
	--       ]],
	-- 			false
	-- 		)
	-- 	end,
	-- },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "max397574/better-escape.nvim", name = "better_escape", event = "VeryLazy" },
	
}
