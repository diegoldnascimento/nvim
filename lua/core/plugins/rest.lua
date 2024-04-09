-- Lazy loading LuaRocks dependencies for lazy.nvim
return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		keys = {
			{
				"<leader>rr",
				"<cmd>Rest run<CR>",
				mode = { "n", "v" },
				desc = "Run request under the cursor",
			},
			{
				"<leader>rl",
				"<cmd>Rest run last<CR>",
				mode = { "n", "v" },
				desc = "Re-run latest request",
			},
		},
		config = function(_, opts)
			require("rest-nvim").setup(opts)
		end,
	},
}
