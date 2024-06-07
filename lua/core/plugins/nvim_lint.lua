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
				python = { "pylint" },
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
		config = function(_, opts)
			local lint = require("lint")

			if not opts.linters then
				lint.linters = opts.linters
				return
			end

			if not opts.linters_by_ft then
				lint.linters_by_ft = opts.linters_by_ft
				return
			end

			local lint_auto = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
				group = lint_auto,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
