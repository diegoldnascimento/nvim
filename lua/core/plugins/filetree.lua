return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local options = {
			sort_by = "case_sensitive",
			auto_reload_on_write = true,
			create_in_closed_folder = false,
			hijack_cursor = true,
			hijack_netrw = true,
			open_on_tab = false,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = true,
			},
			git = {
				enable = false,
				ignore = true,
			},
			filesystem_watchers = {
				enable = true,
			},
			actions = {
				open_file = {
					resize_window = true,
				},
			},
			filters = {
				dotfiles = false,
				custom = { "^.git$", "node_modules" },
			},
			renderer = {
				root_folder_label = false,
				highlight_git = false,
				highlight_opened_files = "none",

				indent_markers = {
					enable = false,
				},

				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = false,
					},

					glyphs = {
						default = "󰈚",
						symlink = "",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",
							arrow_open = "",
							arrow_closed = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
		}

    require("nvim-tree").setup(options)

		-- Remap Enter key to do nothing
		vim.api.nvim_set_keymap("n", "<CR>", "<NOP>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("v", "<CR>", "<NOP>", { noremap = true, silent = true })
		-- empty setup using defaults
	end,
}
