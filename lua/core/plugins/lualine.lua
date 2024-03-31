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
			--
			require("lualine").setup({
				options = {
					theme = dracula,
					globalstatus = true,
					disabled_filetypes = {
						statusline = {
							"dashboard",
							"alpha",
							"NvimTree",
							"lazy",
							"Telescope",
							"telescope",
							"TelescopePrompt",
						},
					},
				},
				sections = {
					lualine_b = {
						"branch",
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						"filetype",
					},
				},
			})
		end,
	},
}
