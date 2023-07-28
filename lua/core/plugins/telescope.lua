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

			local project = require("project_nvim")

			project.setup({
				active = true,
				on_config_done = nil,
				manual_mode = false,
				detection_methods = { "pattern" },
				patterns = {
					".git",
					"_darcs",
					".hg",
					".bzr",
					".svn",
					"Makefile",
					"package.json",
				},
				show_hidden = false,
				silent_chdir = true,
				ignore_lsp = {},
				datapath = vim.fn.stdpath("data"),
			})

			telescope.load_extension("fzf")
			telescope.load_extension("projects")
		end,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "ahmedkhalf/project.nvim" },
		},
	},
}
