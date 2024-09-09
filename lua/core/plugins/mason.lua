return {
	{
		"williamboman/mason.nvim",
		build = function()
			pcall(vim.api.nvim_command, "MasonUpdate")
		end,
		opts = {
			max_concurrent_installers = 12,
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		init = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function()
			local lsp_zero = require("lsp-zero").preset("recommended")

			local opts = {
				ensure_installed = {
					"astro",
					"jsonls",
					"terraformls",
					"yamlls",
					"lua_ls",
					"ts_ls",
          "ltex",
					"svelte",
					"bashls",
          "sqlls",
					"html",
					"gopls",
					"eslint",
					"dockerls",
					"cssls",
					"cssmodules_ls",
					"html",
					"graphql",
					"prismals",
					"intelephense",
					"pyright",
					"nil_ls",
				},
				automatic_installation = true,
				handlers = {
					lsp_zero.default_setup,
				},
			}

			return opts
		end,
		init = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"shfmt",
				"eslint_d",
				"black",
				"isort",
				"jq",
				"goimports",
				"tflint",
				"jsonlint",
				"php-cs-fixer",
				"codespell",
				"yamlfix",
				"hadolint",
				"pylint",
				"nixpkgs-fmt",
				"cspell",
				"luacheck",
			},
			automatic_installation = true,
		},
		init = function(_, opts)
			require("mason-null-ls").setup(opts)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {

			ensure_installed = {
				"chrome",
			},
			automatically_installation = true,
		},
		init = function(_, opts)
			require("mason-nvim-dap").setup(opts)
		end,
	},
}
