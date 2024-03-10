return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		build = ":Copilot auth",
		opts = {
			suggestion = {
        enabled = false,
			},
      panel = {
        enabled = false,
      },
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "VeryLazy",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
