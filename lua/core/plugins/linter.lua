return {
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
