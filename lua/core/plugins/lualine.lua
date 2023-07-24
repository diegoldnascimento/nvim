return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local status_ok, lualine = pcall(require, "lualine")

			if not status_ok then
				return
			end

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

			local illusion_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.black, bg = colors.black },
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

			lualine.setup({
				options = {
					theme = illusion_theme,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "NvimTree", "packer" } },
				},
			})
		end,
	},
}
