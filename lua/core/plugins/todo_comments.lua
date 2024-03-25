return {
	"folke/todo-comments.nvim",
	keys = {
		{
			mode = "n",
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			mode = "n",
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous todo comment",
		},
		{
			mode = "n",
			"<leader>ft",
      "<cmd>TodoTelescope<cr>",
			desc = "Previous todo comment",
		},
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	init = function()
		require("todo-comments").setup()
	end,
}
