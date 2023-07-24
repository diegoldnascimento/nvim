return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local status_ok, telescope = pcall(require, "telescope")

			if not status_ok then
				return
			end

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
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = false, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
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
