return {
	"gbprod/yanky.nvim",
	enabled = true,
	lazy = true,
	keys = {
		{
			"<leader>fy",
			function()
				local tele_status_ok, telescope = pcall(require, "telescope")
				if not tele_status_ok then
					return
				end

				telescope.extensions.yank_history.yank_history({})
			end,
			desc = "Open Yank History",
		},
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
		{ "P", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
		{ "p", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
		{ "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
		{ "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
	},
	opts = {
		preserve_cursor_position = {
			enabled = true,
		},
		ring = {
			history_length = 25,
		},
		highlight = {
			timer = 125,
		},
	},
}
