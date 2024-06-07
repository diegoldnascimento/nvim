-- Lazy loading LuaRocks dependencies for lazy.nvim
return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = { "http", "https" },
		dependencies = { { "nvim-lua/plenary.nvim" } },
		tag = "v1.2.1",
		keys = {
			{
				"<leader>rr",
				"<Plug>RestNvim",
				mode = { "n", "v" },
				desc = "Run request under the cursor",
			},
			{
				"<leader>rp",
				"<Plug>RestNvimPreview",
				mode = { "n", "v" },
				desc = "Preview the request cURL command",
			},
			{
				"<leader>rl",
				"<Plug>RestNvimLast",
				mode = { "n", "v" },
				desc = "Re-run latest request",
			},
		},
		config = function(_, opts)
			require("rest-nvim").setup(opts)
		end,
	},
}
