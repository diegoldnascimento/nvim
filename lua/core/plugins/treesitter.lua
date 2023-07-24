return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
}
