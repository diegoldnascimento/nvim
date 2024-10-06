return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			local success, copilot = pcall(require, "copilot")
			if success then
				copilot.setup({
					panel = { enabled = false },
					suggestion = { enabled = false },
				})
			else
				print("Error: copilot module not found")
			end
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
			prompts = {
				-- Code related prompts
				Explain = "Please explain how the following code works.",
				Review = {
					prompt = "Please review the following code and provide suggestions for improvement.",
					mapping = "<leader>cr",
				},
				Tests = "Please explain how the selected code works, then generate unit tests for it.",
				Refactor = "Please refactor the following code to improve its clarity and readability.",
				FixCode = "Please fix the following code to make it work as intended.",
				FixError = "Please explain the error in the following text and provide a solution.",
				BetterNamings = "Please provide better names for the following variables and functions.",
				Documentation = "Please provide documentation for the following code.",
				SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
				SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
				-- Text related prompts
				Summarize = "Please summarize the following text.",
				Spelling = "Please correct any grammar and spelling errors in the following text.",
				Wording = "Please improve the grammar and wording of the following text.",
				Concise = "Please rewrite the following text to make it more concise.",
			},
			mappings = {
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				reset = {
					normal = "<C-l>",
					insert = "<C-l>",
				},
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-CR>",
				},
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				yank_diff = {
					normal = "gy",
					register = '"',
				},
				show_diff = {
					normal = "gd",
				},
				show_system_prompt = {
					normal = "gp",
				},
				show_user_selection = {
					normal = "gs",
				},
			},
		},
		event = "VeryLazy",
		keys = {
			{
				"<leader>cb",
				":CopilotChatBuffer<cr>",
				desc = "CopilotChat - Chat with current buffer",
				mode = { "n", "v", "x" },
			},
			{
				"<leader>ce",
				"<cmd>CopilotChatExplain<cr>",
				desc = "CopilotChat - Explain code",
				mode = { "n", "v" },
			},
			{
				"<leader>cd",
				"<cmd>CopilotChatDocs<cr>",
				desc = "CopilotChat - Generate Docs",
				mode = { "n", "v" },
			},
			{
				"<leader>ct",
				"<cmd>CopilotChatTests<cr>",
				desc = "CopilotChat - Generate tests",
				mode = { "n", "v" },
			},
			{
				"<leader>cc",
				"<cmd>CopilotChatToggle<cr>",
				desc = "CopilotChat - Toggle chat",
				mode = { "n", "v" },
			},
			{
				"<leader>cg",
				"<cmd>CopilotChatCommit<cr>",
				desc = "CopilotChat - Generate Commit",
				mode = { "n", "v" },
			},
			{
				"<leader>cv",
				"<cmd>CopilotChatVsplitToggle<cr>",
				desc = "CopilotChat - Toggle vertical split",
				mode = { "n", "v" },
			},
			{
				"<leader>cf",
				"<cmd>CopilotChatFixDiagnostic<cr>",
				desc = "CopilotChat - Fix diagnostic",
				mode = { "n", "v" },
			},
			{
				"<leader>cr",
				"<cmd>CopilotChatReset<cr>",
				desc = "CopilotChat - Reset chat history and clear buffer",
				mode = { "n", "v" },
			},
			{
				"<leader>co",
				"<cmd>CopilotChatOptimize<cr>",
				desc = "CopilotChat - Optimize code",
				mode = { "n", "v" },
			},
			{
				"<leader>ch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
				mode = { "n", "v" },
			},
			{
				"<leader>cp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
				mode = { "n", "v" },
			},
			{
				"<leader>cq",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "CopilotChat - Ask input",
				mode = { "n", "v", "x" },
			},
		},
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function(_, opts)
			local success, chat = pcall(require, "CopilotChat")
			if success then
				chat.setup(opts)
			else
				print("Error: CopilotChat module not found")
			end
		end,
	},
}
