return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local opts = {
				options = {
					theme = "sequoia",
					globalstatus = true,
					disabled_filetypes = {
						statusline = {
							"dashboard",
							"alpha",
							"NvimTree",
							"neo-tree",
							"lazy",
							"FzfLua",
							"fzf",
							"copilot-chat",
							"lazygit",
						},
					},
				},
				sections = {
					lualine_b = {
						"branch",
						"diff",
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
						},
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						"encoding",
						{
							function()
								local bufnr = vim.api.nvim_get_current_buf()
								local clients = vim.lsp.buf_get_clients(bufnr)
								if next(clients) == nil then
									return "No LSP"
								end
								local buf_client_names = {}
								for _, client in pairs(clients) do
									table.insert(buf_client_names, client.name)
								end
								return table.concat(buf_client_names, ", ")
							end,
							icon = "",
						},
						"filetype",
					},
				},
			}

			local trouble = require("trouble")
			local symbols = trouble.statusline({
				mode = "lsp_document_symbols",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
				hl_group = "lualine_c_normal",
			})
			table.insert(opts.sections.lualine_c, {
				symbols.get,
				cond = symbols.has,
			})

			require("lualine").setup(opts)
		end,
		dependencies = {
			{ "Davidyz/VectorCode" },
		},
	},
}
