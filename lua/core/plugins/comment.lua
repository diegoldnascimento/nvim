return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			local status_ok, comment = pcall(require, "Comment")

			if not status_ok then
				return
			end

			local opts = {
				padding = true,
				sticky = true,
				ignore = nil,
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				opleader = {
					line = "gc",
					block = "gb",
				},
				extra = {
					above = "gcO",
					below = "gco",
					eol = "gcA",
				},
				mappings = {
					basic = true,
					extra = true,
					extended = false,
				},
				pre_hook = nil,
				post_hook = nil,
			}

			comment.setup(opts)
		end,
	},
}
