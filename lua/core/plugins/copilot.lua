return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = { enabled = false },
				suggestion = { enabled = false },
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		build = "make tiktoken",
		opts = {
			debug = false,
			show_help = "yes",
			language = "English",
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>cb", ":CopilotChatBuffer ", desc = "CopilotChat - Chat with current buffer" },
			{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = "CopilotChat - Generate Docs" },
			{ "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
			{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle chat" },
			{ "<leader>cg", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate Commit" },
			{
				"<leader>cv",
				"<cmd>CopilotChatVsplitToggle<cr>",
				desc = "CopilotChat - Toggle vertical split",
			},
			{ "<leader>cf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix diagnostic" },
			{
				"<leader>cr",
				"<cmd>CopilotChatReset<cr>",
				desc = "CopilotChat - Reset chat history and clear buffer",
			},
			{ "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "CopilotChat - Optimize code" },
		},
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
	},
}
