return {
	{
		"mfussenegger/nvim-lint",
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		opts = {
			linters_by_ft = {
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				json = { "jsonlint" },
				python = { "flake8" },
				terraform = { "tflint" },
			},

			linters = {
				eslint_d = {
					args = {
						"--no-warn-ignored",
						"--format",
						"json",
						"--stdin",
						"--stdin-filename",
						function()
							return vim.api.nvim_buf_get_name(0)
						end,
					},
				},
			},
		},
		config = function()
		end,
	},
}
