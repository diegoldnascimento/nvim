return {
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			draw = {
				delay = 0,
				animation = function()
					return 0
				end,
			},
			options = { border = "top", try_as_border = true },
			symbol = "▏",
		},
		config = function(_, opts)
			require("mini.indentscope").setup(opts)

			-- Disable for certain filetypes
			vim.api.nvim_create_autocmd({ "FileType" }, {
				desc = "Disable indentscope for certain filetypes",
				callback = function()
					local ignore_filetypes = {
						"aerial",
						"dashboard",
						"help",
						"lazy",
						"leetcode.nvim",
						"mason",
						"neo-tree",
						"NvimTree",
						"neogitstatus",
						"notify",
						"startify",
						"toggleterm",
						"Trouble",
					}
					if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
						vim.b.miniindentscope_disable = true
					end
				end,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "ys", -- Add surrounding in Normal mode
				delete = "ds", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "cs", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
			n_lines = 100,
		},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
	},
	{
		"echasnovski/mini.bufremove",
		event = "BufReadPre",
	},
}
