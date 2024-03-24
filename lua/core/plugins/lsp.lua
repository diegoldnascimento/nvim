return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
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
				"nvimdev/lspsaga.nvim",
				config = function()
					require("lspsaga").setup({})
				end,
			},
		},
		init = function()
			local lsp_zero = require("lsp-zero").preset({})

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			lsp_zero.setup()

			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_nvim_dap = require("mason-nvim-dap")
			local mason_nvim_null_ls = require("mason-null-ls")

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
				handlers = {
					lsp_zero.default_setup,
				},
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
