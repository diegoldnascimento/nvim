return {
	{
		"zbirenbaum/copilot.lua",
		event = { "InsertEnter", "LspAttach" },
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = false,
			},
			panel = {
				enabled = false,
			},
			server_opts_overrides = {},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		opts = {
			event = { "InsertEnter", "LspAttach" },
			fix_pairs = true,
		},
		config = function(_, opts)
			require("copilot_cmp").setup(opts)
		end,
	},
}
