return {
	{
		"williamboman/mason.nvim",
		build = function()
			pcall(vim.api.nvim_command, "MasonUpdate")
		end,
		opts = {
			max_concurrent_installers = 4,
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
			local lsp_zero = require("lsp-zero").preset()

			local opts = {
				ensure_installed = {
					"jsonls",
					"terraformls",
					"yamlls",
					"lua_ls",
					"tsserver",
					"svelte",
					"sqlls",
					"gopls",
					"eslint",
					"dockerls",
					"cssls",
					"html",
					"graphql",
					"prismals",
					"intelephense",
					"pyright",
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
			{ "jose-elias-alvarez/null-ls.nvim" },
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
				"markdownlint",
				"php-cs-fixer",
				"codespell",
				"yamlfix",
				"hadolint",
				"pylint",
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
