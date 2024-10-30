return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{
				"[b",
				"<Cmd>BufferLineCyclePrev<CR>",
				mode = { "n" },
				desc = "Cycle to previous buffer",
			},
			{
				"]b",
				"<Cmd>BufferLineCycleNext<CR>",
				mode = { "n" },
				desc = "Cycle to next buffer",
			},
			{
				"<S-h>",
				"<Cmd>BufferLineCyclePrev<CR>",
				mode = { "n" },
				desc = "Cycle to previous buffer",
			},
			{
				"<S-l>",
				"<Cmd>BufferLineCycleNext<CR>",
				mode = { "n" },
				desc = "Cycle to next buffer",
			},
			{
				"[[b",
				"<Cmd>BufferLineMovePrev<CR>",
				mode = { "n" },
				desc = "Move buffer to previous position",
			},
			{
				"]]b",
				"<Cmd>BufferLineMoveNext<CR>",
				mode = { "n" },
				desc = "Move buffer to next position",
			},
			{
				"[B",
				"<cmd>BufferLineGoToBuffer 1<CR>",
				mode = { "n" },
				desc = "Go to buffer 1",
			},
			{
				"]B",
				"<cmd>BufferLineGoToBuffer 99<cr>",
				mode = { "n" },
				desc = "Go to buffer 99",
			},
			{
				"<Leader>w",
				"<cmd>BufferLinePickClose<cr>",
				mode = { "n" },
				desc = "Pick and close buffer",
			},
			{
				"<Leader>bb",
				"<cmd>BufferOrderByBufferNumber<cr>",
				mode = { "n" },
				desc = "Order buffers by buffer number",
			},
			{
				"<Leader>bq",
				"<cmd>BufferLineCloseOthers<cr>",
				mode = { "n" },
				desc = "Order buffers by buffer number",
			},
			{
				"<Leader>bd",
				"<cmd>BufferOrderByDirectory<cr>",
				mode = { "n" },
				desc = "Order buffers by directory",
			},
			{
				"<Leader>bl",
				"<cmd>BufferOrderByLanguage<cr>",
				mode = { "n" },
				desc = "Order buffers by language",
			},
			{
				"<Leader>bw",
				"<cmd>BufferOrderByWindowNumber<cr>",
				mode = { "n" },
				desc = "Order buffers by window number",
			},
			{
				"<C-w>",
				function(n)
					require("mini.bufremove").delete(n, false)
				end,
				mode = { "n" },
				desc = "Close buffer",
			},
		},

		opts = {
			options = {
				mode = "buffers",
				numbers = "none",
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				middle_mouse_command = nil,
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30,
				tab_size = 21,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = true,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = true,
				persist_buffer_sort = true,
				separator_style = "thin",
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				sort_bv = "id",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
}
