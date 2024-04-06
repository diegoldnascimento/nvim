return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					file_ignore_patterns = {
						"^node_modules/",
						"^vendor/",
						"^tmp/",
						"^dist/",
						"^.git/",
						"^.vscode/",
						"^dist/",
						"^build/",
						"^coverage/",
						"^packages/",
						"^logs/",
						"^.npm/",
						"^.next/",
						"%.log",
						"%.DS_Store",
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = false,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					mappings = {
						i = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<C-q>"] = require("telescope.actions").send_to_qflist,
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	},
}
