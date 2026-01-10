return {
	"gbprod/yanky.nvim",
	enabled = true,
	event = "VeryLazy",
	keys = {
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after cursor" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before cursor" },
		{ "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
		{ "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
	},
	opts = {
		ring = {
			history_length = 100,
			storage = "shada",
			sync_with_numbered_registers = true,
		},
		system_clipboard = {
			sync_with_ring = false,  -- CRITICAL: Prevents wl-copy freezes
		},
		highlight = {
			on_put = true,
			on_yank = true,
			timer = 100,
		},
		preserve_cursor_position = {
			enabled = true,
		},
	},
}
