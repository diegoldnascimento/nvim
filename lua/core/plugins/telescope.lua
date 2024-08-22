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
		keys = {
			{
				mode = "n",
				"<c-p>",
				function()
					require("telescope.builtin").find_files({
						find_command = { "rg", "--ignore", "--hidden", "--files" },
					})
				end,
				desc = "Find files",
			},
			{
				mode = "n",
				"<Leader>ff",
				function()
					require("telescope.builtin").find_files({
						find_command = { "rg", "--ignore", "--hidden", "--files" },
					})
				end,
				desc = "Find files",
			},
			{
				mode = "n",
				"<Leader>fa",
				function()
					require("telescope.builtin").find_files({ follow = true, no_ignore = true, hidden = true })
				end,
				desc = "Find all files (including hidden and ignored)",
			},
			{
				mode = "n",
				"<Leader>fg",
				function()
					require("telescope.builtin").live_grep({ additional_args = { "--fixed-strings" } })
				end,
				desc = "Live grep (fixed strings)",
			},
			{
				mode = "n",
				"<Leader>fG",
				function()
					require("telescope.builtin").live_grep({ search_dirs = { "%:p" } })
				end,
				desc = "Live grep in current directory",
			},
			{
				mode = "n",
				"<Leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Search help tags",
			},
			{
				mode = "n",
				"<Leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "List open buffers",
			},
			{
				mode = "n",
				"<Leader>fo",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "Find recently opened files",
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
