return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	config = function()
		local status_ok, bufferline = pcall(require, "bufferline")
		if not status_ok then
			return
		end

		bufferline.setup({
			options = {
				mode = "buffers",
				numbers = "none",
				close_command = function(bufnr)
					require("bufdel").delete_buffer_expr(bufnr)
				end,
				right_mouse_command = "vert sbuffer %d",
				left_mouse_command = "buffer %d",
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
				diagnostics_update_in_insert = false,
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
					{ filetype = "NvimTree" },
				},
			},
		})
	end,
}
