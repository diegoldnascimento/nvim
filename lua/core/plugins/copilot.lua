return {
	{
		"zbirenbaum/copilot.lua",
		event = { "InsertEnter", "LspAttach" },
		fix_pairs = true,
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-l>",
					accept_word = false,
					accept_line = false,
					-- next = "<C-]>",
					-- prev = "<C-[>",
					-- dismiss = "<C-o>",
				},
			},
			panel = {
				enabled = false,
			},
			copilot_node_command = "node",
			server_opts_overrides = {},
		},
		config = function(_, opts)
      local keymap = vim.api.nvim_set_keymap
      -- keymap("i", "<C-[>", "<cmd>lua require('copilot').next()<CR>", { noremap = true, silent = true })
			require("copilot").setup(opts)
		end,
	},
}
