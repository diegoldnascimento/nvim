return {
	{
		"nvim-telescope/telescope.nvim",
		opts = {
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
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local telescope_actions = require("telescope.actions")
			opts.defaults.mappings = {
				i = {
					["<C-j>"] = telescope_actions.move_selection_next,
					["<C-k>"] = telescope_actions.move_selection_previous,
					["<C-q>"] = telescope_actions.send_to_qflist,
					["<C-y>"] = telescope_actions.select_default,
					["<C-e>"] = telescope_actions.close,
				},
			}
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	},
}
