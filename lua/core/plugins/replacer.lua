return {
	"gabrielpoca/replacer.nvim",
	opts = { rename_files = false },
	keys = {
		{
			"<leader>fr",
			function()
				require("replacer").run()
			end,
			desc = "run replacer.nvim",
		},

		{
			"<leader>fR",
			function()
				require("replacer").save()
			end,
			desc = "save replacer.nvim",
		},
	},
	event = "VeryLazy",
}
