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

			-- Disable tsserver and ts_ls
			lspconfig.tsserver.setup({ enabled = false })
			lspconfig.ts_ls.setup({ enabled = false })

			-- Setup vtsls
			local vtsls_settings = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
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
						tsserver = {
							maxTsServerMemory = 8192, -- 8GB in MB
						},
					},
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
				},
				on_attach = function(client, buffer)
					-- Add vtsls specific keybindings
					vim.keymap.set("n", "gD", function()
						local params = vim.lsp.util.make_position_params()
						vim.lsp.buf.execute_command({
							command = "typescript.goToSourceDefinition",
							arguments = { params.textDocument.uri, params.position },
						})
					end, { buffer = buffer, desc = "Goto Source Definition" })

					vim.keymap.set("n", "gR", function()
						vim.lsp.buf.execute_command({
							command = "typescript.findAllFileReferences",
							arguments = { vim.uri_from_bufnr(0) },
						})
					end, { buffer = buffer, desc = "File References" })

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
						code_action("source.addMissingImports.ts"),
						{ buffer = buffer, desc = "Add missing imports" }
					)

					vim.keymap.set(
						"n",
						"<leader>cu",
						code_action("source.removeUnused.ts"),
						{ buffer = buffer, desc = "Remove unused imports" }
					)

					vim.keymap.set(
						"n",
						"<leader>cd",
						code_action("source.fixAll.ts"),
						{ buffer = buffer, desc = "Fix all diagnostics" }
					)

					vim.keymap.set("n", "<leader>cV", function()
						vim.lsp.buf.execute_command({ command = "typescript.selectTypeScriptVersion" })
					end, { buffer = buffer, desc = "Select TS workspace version" })

					-- Setup move to file refactoring command
					client.commands["_typescript.moveToFileRefactoring"] = function(command, _)
						---@type string, string, table
						local action, uri, range = unpack(command.arguments)

						local function move(newf)
							client.request("workspace/executeCommand", {
								command = command.command,
								arguments = { action, uri, range, newf },
							})
						end

						local fname = vim.uri_to_fname(uri)
						client.request("workspace/executeCommand", {
							command = "typescript.tsserverRequest",
							arguments = {
								"getMoveToRefactoringFileSuggestions",
								{
									file = fname,
									startLine = range.start.line + 1,
									startOffset = range.start.character + 1,
									endLine = range["end"].line + 1,
									endOffset = range["end"].character + 1,
								},
							},
						}, function(_, result)
							---@type string[]
							local files = result.body.files
							table.insert(files, 1, "Enter new path...")
							vim.ui.select(files, {
								prompt = "Select move destination:",
								format_item = function(f)
									return vim.fn.fnamemodify(f, ":~:.")
								end,
							}, function(f)
								if f and f:find("^Enter new path") then
									vim.ui.input({
										prompt = "Enter move destination:",
										default = vim.fn.fnamemodify(fname, ":h") .. "/",
										completion = "file",
									}, function(newf)
										return newf and move(newf)
									end)
								elseif f then
									move(f)
								end
							end)
						end)
					end
				end,
			}

			-- Copy typescript settings to javascript
			vtsls_settings.settings.javascript = vim.tbl_deep_extend(
				"force",
				{},
				vtsls_settings.settings.typescript,
				vtsls_settings.settings.javascript or {}
			)
			lspconfig.vtsls.setup(vtsls_settings)

			lsp_zero.setup()
		end,
	},
}
