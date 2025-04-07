return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local colors = {
				blue = "#80a0ff",
				cyan = "#8BE9FD",
				black = "#1E1D22",
				white = "#F8F8F2",
				red = "#FF6E6E",
				violet = "#BD93F9",
				grey = "#44475A",
				green = "#50FA7B",
			}

			local dracula = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white, bg = colors.black },
				},

				insert = { a = { fg = colors.black, bg = colors.green } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.black, bg = colors.black },
				},
			}

			local opts = {
				options = {
					theme = dracula,
					globalstatus = true,
					disabled_filetypes = {
						statusline = {
							"dashboard",
							"alpha",
							"NvimTree",
							"neo-tree",
							"lazy",
							"FzfLua",
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
								local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
								if #buf_clients == 0 then
									return "No LSP"
								end
								local buf_client_names = {}
								for _, client in pairs(buf_clients) do
									table.insert(buf_client_names, client.name)
								end
								return table.concat(buf_client_names, ", ")
							end,
							icon = "  LSP:",
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
				-- The following line is needed to fix the background color
				-- Set it to the lualine section you want to use
				hl_group = "lualine_c_normal",
			})
			table.insert(opts.sections.lualine_c, {
				symbols.get,
				cond = symbols.has,
			})
			--
			require("lualine").setup(opts)
		end,
	},
}
