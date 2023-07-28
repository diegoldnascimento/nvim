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
				},
			})

			telescope.load_extension("fzf")
		end,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}
