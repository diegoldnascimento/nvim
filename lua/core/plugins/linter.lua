return {
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("lint").linters_by_ft = {
				typescript = { "eslint" },
				javascript = { "eslint" },
				json = { "jsonlint" },
				python = { "flake8" },
				terraform = { "tflint" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
