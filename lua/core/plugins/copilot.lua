return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = false,
		},
		keys = {
			{
				"<leader>cc",
				"<cmd>CopilotChatToggle<cr>",
				desc = "CopilotChat - Help actions",
			},
			{
				"<leader>ct",
				"<cmd>CopilotChatTests<cr>",
				desc = "Run command for Copilot to generate Tests",
			},
			{
				"<leader>ch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
			},
			{
				"<leader>cp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
		},
	},
}
