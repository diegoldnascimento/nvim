return {
	{
		"stevearc/oil.nvim",
		opts = {
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				mode = { "n", "v" },
				"-",
				"<CMD>Oil<CR>",
				desc = "Open parent directory",
			},
			{

				mode = { "n", "v" },
				"<leader>-",
				function()
					require("oil").toggle_float()
				end,
				desc = "Open parent directory in Float Mode",
			},
		},
		config = function(_, opts)
			require("oil").setup(opts)
		end,
	},
}
