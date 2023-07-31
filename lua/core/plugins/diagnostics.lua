return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({})
		local keymap = vim.keymap

		keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
		keymap.set("n", "<leader>xw", function()
			require("trouble").open("workspace_diagnostics")
		end)
		keymap.set("n", "<leader>xd", function()
			require("trouble").open("document_diagnostics")
		end)
		keymap.set("n", "<leader>xq", function()
			require("trouble").open("quickfix")
		end)
		keymap.set("n", "<leader>xl", function()
			require("trouble").open("loclist")
		end)
	end,
}
