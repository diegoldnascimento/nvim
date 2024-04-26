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
				typescriptreact = { "prettierd" },
				javascriptreact = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				json = { "jq" },
				go = { "goimports", "gofumpt" },
				sh = { "shfmt" },
				markdown = { "prettierd", "codespell" },
				yaml = { "yamlfix" },
				php = { "php-cs-fixer" },
				python = { "isort", "black" },
				nix = { "nixpkgs-fmt" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			notify_on_error = true,
		},
		init = function(_, opts)
			require("conform").setup(opts)
		end,
	},
}
