return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "-" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
}
