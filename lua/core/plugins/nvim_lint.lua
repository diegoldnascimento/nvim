return {
	{
		"mfussenegger/nvim-lint",
		events = { "BufReadPre", "BufNewFile" },
		opts = {
			linters_by_ft = {
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				json = { "jsonlint" },
				dockerfile = { "hadolint" },
				python = { "flake8" },
				markdown = { "markdownlint" },
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
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
