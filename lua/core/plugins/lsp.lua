return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.api.nvim_command, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
			{ "jay-babu/mason-nvim-dap.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
		},
		init = function()
			local lsp = require("lsp-zero").preset({})
			local navic = require("nvim-navic")

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })

				if client.name == "copilot" or client.name == "tailwindcss" then
					return
				end
				navic.attach(client, bufnr)
			end)
			lsp.setup()

			local status_mason_ok, mason = pcall(require, "mason")

			local status_mason_config_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

			local status_mason_nvim_dap, mason_nvim_dap = pcall(require, "mason-nvim-dap")

			local status_mason_null_ls, mason_nvim_null_ls = pcall(require, "mason-null-ls")

			local servers = {
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
				"marksman",
				"rust_analyzer",
				"intelephense",
				"pyright",
        "tailwindcss",
			}

			local daps = {
				"chrome",
				-- "node2",
			}

			local null_ls = {
				"stylua",
				"prettierd",
				"shfmt",
				"eslint_d",
				"flake8",
				"black",
				"jq",
				"gofumpt",
				"tflint",
				"jsonlint",
				"markdownlint",
				"php-cs-fixer",
			}

			mason.setup({
				max_concurrent_installers = 4,
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				ensure_installed = servers,
				automatic_installation = true,
			})

			mason_nvim_dap.setup({
				ensure_installed = daps,
				automatically_installation = true,
			})

			mason_nvim_null_ls.setup({
				ensure_installed = null_ls,
			})
		end,
	},
}
