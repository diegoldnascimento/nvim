return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},

		keys = {
			-- Diego: Im using LSP Saga keys to replace native LSP from Neovim

			-- {
			-- 	"gd",
			-- 	function()
			-- 		vim.lsp.buf.definition()
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to definition",
			-- },
			-- {
			-- 	"gD",
			-- 	function()
			-- 		vim.lsp.buf.declaration()
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to declaration",
			-- },
			-- {
			-- 	"gi",
			-- 	function()
			-- 		vim.lsp.buf.implementation()
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to implementation",
			-- },
			-- {
			-- 	"X",
			-- 	function()
			-- 		vim.diagnostic.open_float(0, { scope = "line" })
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Show line diagnostics",
			-- },
			-- {
			-- 	"gr",
			-- 	function()
			-- 		vim.lsp.buf.references()
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Show references",
			-- },
			-- {
			-- 	"[e",
			-- 	function()
			-- 		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to previous error diagnostic",
			-- },
			-- {
			-- 	"]e",
			-- 	function()
			-- 		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to next error diagnostic",
			-- },
			-- {
			-- 	"[w",
			-- 	function()
			-- 		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to previous warning diagnostic",
			-- },
			-- {
			-- 	"]w",
			-- 	function()
			-- 		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to next warning diagnostic",
			-- },
			-- {
			-- 	"[d",
			-- 	function()
			-- 		vim.diagnostic.goto_prev()
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to previous diagnostic",
			-- },
			-- {
			-- 	"]d",
			-- 	function()
			-- 		vim.diagnostic.goto_next()
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Go to next diagnostic",
			-- },
			{
				"K",
				function()
					vim.lsp.buf.hover()
				end,
				mode = { "n", "v" },
				desc = "Show hover documentation",
			},
			{
				"gx",
				function()
					vim.diagnostic.setqflist()
				end,
				mode = { "n", "v" },
				desc = "Show workspace diagnostics",
			},
			{
				"<leader>cx",
				function()
					vim.lsp.codelens.run()
				end,
				mode = { "n", "v" },
				desc = "Run code Lens",
			},

			-- {
			-- 	"<leader>cs",
			-- 	function()
			-- 		vim.lsp.buf.document_symbol()
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Show document symbols",
			-- },
		},
		config = function()
			local lsp_zero = require("lsp-zero").preset("recommended")

			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			-- Configure server options from what was previously in nvim-lspconfig
			local lspconfig = require("lspconfig")

			-- Enable tsserver instead of vtsls
			lspconfig.vtsls.setup({ enabled = false })

			-- Setup tsserver
			local tsserver_settings = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
					javascript = {}, -- This will be filled below
					completions = {
						completeFunctionCalls = true,
					},
				},
				on_attach = function(client, buffer)
					-- Add tsserver specific keybindings
					vim.keymap.set("n", "gD", function()
						vim.lsp.buf.declaration()
					end, { buffer = buffer, desc = "Go to Declaration" })

					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, { buffer = buffer, desc = "Go to Definition" })

					vim.keymap.set("n", "gi", function()
						vim.lsp.buf.implementation()
					end, { buffer = buffer, desc = "Go to Implementation" })

					vim.keymap.set("n", "gr", function()
						vim.lsp.buf.references()
					end, { buffer = buffer, desc = "Find References" })

					vim.keymap.set("n", "gR", function()
						vim.lsp.buf.references()
					end, { buffer = buffer, desc = "Find All References" })

					local function code_action(action_name)
						return function()
							vim.lsp.buf.code_action({
								apply = true,
								context = {
									only = { action_name },
									diagnostics = {},
								},
							})
						end
					end

					vim.keymap.set(
						"n",
						"<leader>co",
						code_action("source.organizeImports"),
						{ buffer = buffer, desc = "Organize Imports" }
					)

					vim.keymap.set(
						"n",
						"<leader>cM",
						code_action("source.addMissingImports"),
						{ buffer = buffer, desc = "Add missing imports" }
					)

					vim.keymap.set(
						"n",
						"<leader>cu",
						code_action("source.removeUnused"),
						{ buffer = buffer, desc = "Remove unused imports" }
					)

					vim.keymap.set(
						"n",
						"<leader>cd",
						code_action("source.fixAll"),
						{ buffer = buffer, desc = "Fix all diagnostics" }
					)
				end,
			}

			-- Copy typescript settings to javascript
			tsserver_settings.settings.javascript = vim.tbl_deep_extend(
				"force",
				{},
				tsserver_settings.settings.typescript,
				tsserver_settings.settings.javascript or {}
			)
			lspconfig.tsserver.setup(tsserver_settings)

			lsp_zero.setup()
		end,
	},
}
