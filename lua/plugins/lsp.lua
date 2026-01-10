return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "K", vim.lsp.buf.hover, desc = "Hover documentation" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
			{ "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
			{ "gr", vim.lsp.buf.references, desc = "Go to references" },
			{ "gy", vim.lsp.buf.type_definition, desc = "Go to type definition" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
			{ "<leader>cl", vim.lsp.codelens.run, desc = "Run codelens" },
			{ "gx", vim.diagnostic.setqflist, desc = "Workspace diagnostics" },
			{ "gl", vim.diagnostic.open_float, desc = "Line diagnostics" },
			{ "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Prev diagnostic" },
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configuração global para todos os LSPs
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- vtsls config (alternativa rápida ao ts_ls)
			vim.lsp.config("vtsls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				settings = {
					complete_function_calls = true,
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						experimental = {
							maxInlayHintLength = 30,
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = { completeFunctionCalls = true },
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
						suggest = { completeFunctionCalls = true },
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
				},
			})

			vim.lsp.enable("vtsls")

			-- Keybinds específicos do vtsls
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or client.name ~= "vtsls" then
						return
					end

					local buf = args.buf
					local function ts_action(action)
						return function()
							vim.lsp.buf.code_action({
								apply = true,
								context = { only = { action }, diagnostics = {} },
							})
						end
					end

					local ts_keys = {
						{ "<leader>co", ts_action("source.organizeImports"), "Organize imports" },
						{ "<leader>cM", ts_action("source.addMissingImports"), "Add missing imports" },
						{ "<leader>cu", ts_action("source.removeUnused"), "Remove unused" },
						{ "<leader>cD", ts_action("source.fixAll"), "Fix all" },
					}

					for _, key in ipairs(ts_keys) do
						vim.keymap.set("n", key[1], key[2], { buffer = buf, desc = key[3] })
					end

					-- Code action picker com fzf-lua
					vim.keymap.set("n", "<leader>cf", function()
						local actions = {
							{ "Organize Imports", "source.organizeImports" },
							{ "Add Missing Imports", "source.addMissingImports" },
							{ "Remove Unused", "source.removeUnused" },
							{ "Fix All", "source.fixAll" },
							{ "Extract Function", "refactor.extract.function" },
							{ "Extract Variable", "refactor.extract.constant" },
						}

						require("fzf-lua").fzf_exec(
							vim.tbl_map(function(a)
								return a[1]
							end, actions),
							{
								prompt = "TS Actions> ",
								actions = {
									["default"] = function(selected)
										for _, a in ipairs(actions) do
											if a[1] == selected[1] then
												ts_action(a[2])()
												return
											end
										end
									end,
								},
							}
						)
					end, { buffer = buf, desc = "TS code actions" })
				end,
			})
		end,
	},

	-- Instala vtsls via mason-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"vtsls",
			},
		},
		init = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
}
