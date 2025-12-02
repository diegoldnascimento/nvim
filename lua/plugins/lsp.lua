
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},

		keys = {
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
		},
		config = function()
			-- Get default capabilities for completion
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configure ts_ls using vim.lsp.config
			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
				capabilities = capabilities,
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
					javascript = {
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
					completions = {
						completeFunctionCalls = true,
					},
				},
			})

			-- Setup on_attach for LSP keybindings
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buffer = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					-- Setup ts_ls specific keybindings
					if client and client.name == "ts_ls" then
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
					end
				end,
			})

			-- Enable ts_ls for supported filetypes
			vim.lsp.enable("ts_ls")
		end,
	},
}

