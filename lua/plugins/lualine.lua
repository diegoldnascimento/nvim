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
							symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
						},
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						"encoding",
						{
							function()
								local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

								if next(clients) == nil then
									return "No LSP"
								end
								local buf_client_names = {}
								for _, client in pairs(clients) do
									-- Add buffer count for TypeScript servers
									if client.name == "vtsls" or client.name == "typescript-tools" then
										local buf_count = #vim.lsp.get_buffers_by_client_id(client.id)
										table.insert(buf_client_names, string.format("%s(%d)", client.name, buf_count))
									else
										table.insert(buf_client_names, client.name)
									end
								end
								return table.concat(buf_client_names, ", ")
							end,
							icon = "",
						},
						{
							-- Memory usage indicator for TS server
							function()
								local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
								for _, client in pairs(clients) do
									if client.name == "vtsls" or client.name == "typescript-tools" then
										-- Try to get memory usage
										local handle = io.popen(string.format(
											"ps -p $(pgrep -f 'tsserver|vtsls' | head -1) -o rss= 2>/dev/null"
										))
										if handle then
											local mem_kb = handle:read("*a")
											handle:close()
											if mem_kb and mem_kb ~= "" then
												local mem_mb = tonumber(mem_kb) / 1024
												if mem_mb then
													-- Color code based on usage
													local color = ""
													if mem_mb > 3072 then
														color = "%#DiagnosticError#" -- Red if > 3GB
													elseif mem_mb > 2048 then
														color = "%#DiagnosticWarn#" -- Yellow if > 2GB
													end
													return string.format("%s%.0fMB%%*", color, mem_mb)
												end
											end
										end
									end
								end
								return ""
							end,
							icon = "󰍛",
							cond = function()
								local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
								for _, client in pairs(clients) do
									if client.name == "vtsls" or client.name == "typescript-tools" then
										return true
									end
								end
								return false
							end,
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
	},
}

