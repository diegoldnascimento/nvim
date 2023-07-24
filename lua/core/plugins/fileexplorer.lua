return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
      local oil = require('oil')

			vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })
      oil.setup({})
		end,
	},
}
