return {
	-- Formatter com Biome via conform.nvim
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
				typescript = { "biome" },
				javascript = { "biome" },
				typescriptreact = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				css = { "biome" },
				-- Filetypes não suportados pelo Biome
				lua = { "stylua" },
				scss = { "prettierd" },
				go = { "goimports", "gofumpt" },
				sh = { "shfmt" },
				markdown = { "prettierd" },
				yaml = { "yamlfix" },
				php = { "php-cs-fixer" },
				python = { "isort", "black" },
				nix = { "nix_fmt" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
				["*"] = { "trim_whitespace" },
				["_"] = { "trim_whitespace" },
			},
			notify_on_error = true,
			formatters = {
				nix_fmt = {
					command = "nixfmt",
					stdin = true,
				},
				biome = {
					args = {
						"format",
						"--stdin-file-path",
						"$FILENAME",
						"--format-with-errors",
						"true", -- As a separate argument
					},
				},
			},
		},
	},

	-- Biome LSP para linting
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				biome = {},
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					vim.lsp.buf.code_action({
						filter = function(action)
							return action.isPreferred
						end,
						apply = true,
					})
				end,
				desc = "Fix all (Biome)",
			},
		},
	},
}
