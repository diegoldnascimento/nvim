return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		event = "BufReadPre",
		cmd = "ConformInfo",
		keys = {
			{
				"<C-f>",
				function()
					require("conform").format({ timeout_ms = 500 })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = {
			format = {
				timeout_ms = 500,
				async = false,
				quiet = false,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettierd" },
				javascript = { "prettierd" },
				css = { "prettierd" },
				json = { "jq" },
				go = { "goimports", "gofmt" },
				sh = { "shfmt" },
				markdown = { "prettierd", "codespell" },
				yaml = { "yamlfix" },
				php = { "php-cs-fixer" },
				python = { "isort", "black" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
		},
		init = function(_, opts)
			require("conform").setup(opts)
		end,
	},
}
