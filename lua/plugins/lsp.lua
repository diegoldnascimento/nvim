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

			-- -- Enable ts_ls instead of vtsls
			-- lspconfig.vtsls.setup({ enabled = false })

			-- Setup ts_ls
			local ts_ls_settings = {
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
				on_attach = function(_, buffer)
					-- Add ts_ls specific keybindings
					vim.keymap.set("n", "gD", function()
						vim.lsp.buf.declaration()
					end, { buffer = buffer, desc = "Go to Declaration" })

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

					-- Code actions command picker using fzf-lua
					vim.keymap.set("n", "<leader>cf", function()
						local actions = {
							{ name = "Organize Imports", action = "source.organizeImports" },
							{ name = "Add Missing Imports", action = "source.addMissingImports" },
							{ name = "Remove Unused", action = "source.removeUnused" },
							{ name = "Fix All Diagnostics", action = "source.fixAll" },
							{ name = "Extract Function", action = "refactor.extract.function" },
							{ name = "Extract Variable", action = "refactor.extract.constant" },
							{ name = "Convert to Arrow Function", action = "refactor.rewrite.arrow.function" },
						}

						local fzf = require("fzf-lua")

						local action_names = {}
						for _, act in ipairs(actions) do
							table.insert(action_names, act.name)
						end

						fzf.fzf_exec(action_names, {
							prompt = "Code Actions> ",
							actions = {
								["default"] = function(selected)
									local selected_action = selected[1]
									for _, act in ipairs(actions) do
										if act.name == selected_action then
											code_action(act.action)()
											break
										end
									end
								end,
							},
						})
					end, { buffer = buffer, desc = "Code Action Picker" })

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
			ts_ls_settings.settings.javascript = vim.tbl_deep_extend(
				"force",
				{},
				ts_ls_settings.settings.typescript,
				ts_ls_settings.settings.javascript or {}
			)
			lspconfig.ts_ls.setup(ts_ls_settings)

			lsp_zero.setup()
		end,
	},
}
