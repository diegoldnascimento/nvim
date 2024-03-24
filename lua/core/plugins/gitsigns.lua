return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
    keys = {
      {
        "<leader>gp",
        "<cmd>Gitsigns preview_hunk<CR>",
        mode = { "n", "v" },
        desc = "Preview Hunk",
      }
    },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
}
