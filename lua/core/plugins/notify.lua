return {

	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				background_colour = "#1E1D22",
				render = "wrapped-compact",
			})
		end,
	},
}
