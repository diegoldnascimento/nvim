return {
	{
		"nvimdev/lspsaga.nvim",
		opts = {
			show_code_action = true,
		},
		config = function(_, opts)
			require("lspsaga").setup(opts)
		end,
	},
}
