return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local colors = {
				blue = "#5496bd",   -- Medium blue
				cyan = "#6aabc0",   -- Cyan/teal
				black = "#111111",  -- Dark background
				white = "#e6e6e8",  -- Light text
				red = "#e66868",    -- Soft red
				violet = "#9c86bf", -- Lavender/purple
				grey = "#2c333c",   -- Medium gray
				green = "#6ab68e",  -- Sequoia green
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
