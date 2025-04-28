return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true

			require("dracula").setup({
				colors = {
					bg = "#1E1D22",
					fg = "#F8F8F2",
					menu = "#1E1D22",
					visual = "#3E4452",
					gutter_fg = "#4B5263",
					nontext = "#3B4048",
					selection = "#44475A",
					bright_white = "#FFFFFF",
					white = "#ABB2BF",
					black = "#191A21",
				},
				show_end_of_buffer = true,
				transparent_bg = true,
				italic_comment = true,
				overrides = {},
			})

			vim.cmd([[colorscheme dracula-soft]])
		end,
	},
	{
		"forest-nvim/sequoia.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local palette = {
				_nc = "#0B0B0B",
				base = "#111111",
				surface = "#15161A",
				overlay = "#1A1C22",
				subtle = "#40424A",
				sky = "#2B2D33",
				text = "#E1E1E6",
				lavendar = "#ddd6fe",
				lily = "#E4AA80",
				sun = "#B7A2CC",
				baja = "#89ac8a",
				denim = "#9ABBC7",
				honey = "#E1E1E6",
				grass = "#c8ffc2",
				error = "#ff8585",
				amber = "#E5C07B",
				soil = "#9198A1",
				highlight_low = "#121317",
				highlight_med = "#181A1F",
				highlight_high = "#1F2127",
				none = "NONE",
			}

			local opts = {
				highlight_groups = {
					NvimTreeFolderName = { fg = "#9198A1" },
					NvimTreeOpenedFolderName = { fg = "#9198A1" },
					NvimTreeEmptyFolderName = { fg = "#9198A1" },
					NvimTreeFolderIcon = { fg = "#9198A1" },
					-- Set folder-related highlights for Neo-tree
					NeoTreeDirectoryName = { fg = "#9198A1" },
					NeoTreeDirectoryIcon = { fg = "#9198A1" },

					Directory = { fg = palette.soil, bold = stylesbold },

					DiagnosticSignWarn = { fg = palette.amber },
					DiagnosticFloatingWarn = { fg = palette.amber },
					DiagnosticVirtualTextWarn = { fg = palette.amber },
					DiagnosticUnderlineWarn = { sp = palette.amber, undercurl = true },
					DiagnosticVirtualTextOk = { fg = palette.amber },

					DiagnosticError = { fg = palette.error },
					DiagnosticHint = { fg = palette.grass },
					DiagnosticInfo = { fg = palette.denim },
					DiagnosticOk = { fg = palette.denim },
					DiagnosticWarn = { fg = palette.amber },
				},
			}

			-- require("sequoia").setup(opts)

			-- vim.cmd("colorscheme sequoia-night")
		end,
	},
}
