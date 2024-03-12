return {
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		opts = {
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			enabled = true,
			extended_mode = true,
			color = "Blue",
			highlight_under_cursor = true,
			word_match = true,
			delay = 100,
			filetypes_denylist = {
				"dirbuf",
				"dirvish",
				"nvimtree",
				"alpha",
				"NvimTree",
				"Alpha",
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
}
