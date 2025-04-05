-- Lazy loading LuaRocks dependencies for lazy.nvim
return {
	{
		"mistweaverco/kulala.nvim",
		opts = {},
		keys = {
			{
				"<leader>rr",
				function()
					require("kulala").run()
				end,
				desc = "Run request under the cursor",
			},
			{
				"<leader>rc",
				function()
					require("kulala").copy()
				end,
				desc = "Copies the current request (as cURL command) to the clipboard",
			},
			{
				"<leader>ro",
				function()
					require("kulala").toggle_view()
				end,
				desc = "Toggle result pane",
			},
			{
				"<leader>rq",
				function()
					require("kulala").close()
				end,
				desc = "Close result pane",
			},

			{
				"<leader>rl",
				function()
					require("kulala").replay()
				end,
				desc = "Re-run latest request",
			},
			{
				"<leader>ri",
				function()
					require("kulala").inspect()
				end,
				desc = "Inspects the current request",
			},
			{
				"<leader>r[",
				function()
					require("kulala").jump_prev()
				end,
				desc = "Jump to the previous request",
			},
			{
				"<leader>r]",
				function()
					require("kulala").jump_next()
				end,
				desc = "Jump to the next request",
			},
		},
	},
}
