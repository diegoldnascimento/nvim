return {
	"stevearc/aerial.nvim",
	event = "VeryLazy",
	opts = {
		attach_mode = "global",
		backends = { "lsp", "treesitter", "markdown", "man" },
		ignore = { filetypes = { "NvimTree", "terminal", "nofile" } },
		show_guides = true,
		layout = {
			resize_to_content = false,
			win_opts = {
				winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
				signcolumn = "yes",
				statuscolumn = " ",
			},
			default_direction = "left",
			placement = "window",
		},

		highlight_mode = "split_width",
		keymaps = {
			["?"] = "actions.show_help",
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.jump",
			["<2-LeftMouse>"] = "actions.jump",
			["<C-v>"] = "actions.jump_vsplit",
			["<C-s>"] = "actions.jump_split",
			["p"] = "actions.scroll",
			["<C-j>"] = "actions.down_and_scroll",
			["<C-k>"] = "actions.up_and_scroll",
			["{"] = "actions.prev",
			["}"] = "actions.next",
			["[["] = "actions.prev_up",
			["]]"] = "actions.next_up",
			["q"] = "actions.close",
			["o"] = "actions.tree_toggle",
			["za"] = "actions.tree_toggle",
			["O"] = "actions.tree_toggle_recursive",
			["zA"] = "actions.tree_toggle_recursive",
			["l"] = "actions.tree_open",
			["zo"] = "actions.tree_open",
			["L"] = "actions.tree_open_recursive",
			["zO"] = "actions.tree_open_recursive",
			["h"] = "actions.tree_close",
			["zc"] = "actions.tree_close",
			["H"] = "actions.tree_close_recursive",
			["zC"] = "actions.tree_close_recursive",
			["zr"] = "actions.tree_increase_fold_level",
			["zR"] = "actions.tree_open_all",
			["zm"] = "actions.tree_decrease_fold_level",
			["zM"] = "actions.tree_close_all",
			["zx"] = "actions.tree_sync_folds",
			["zX"] = "actions.tree_sync_folds",
		},
	},
	keys = {
		{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
		{ "{", "<cmd>AerialPrev<CR>", { desc = "Aerial navigate to previous symbol" } },
		{ "}", "<cmd>AerialNext<CR>", { desc = "Aerial navigate to next symbol" } },
	},
	config = function(_, opts)
		require("aerial").setup(opts)
	end,
}
