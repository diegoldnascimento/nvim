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
		branch = "main",
		build = "make tiktoken",
		opts = {
			debug = false,
      model = "claude-3.7-sonnet-thought",
			show_help = "yes",
			language = "English",
			prompts = {
				-- Code related prompts
				Explain = "Please explain how the following code works.",
				Review = {
					prompt = "Please perform a detailed review of the following code, including suggestions for improvement, potential bugs, and adherence to best practices.",
					mapping = "<leader>cr",
				},
				Tests = "Please explain how the selected code works, then generate a comprehensive suite of unit tests for it. Ensure the tests cover a wide range of scenarios, including edge cases, exception handling, and data validation.",
				Refactor = {
					prompt = "Please refactor the following code to improve its clarity and readability.",
					mapping = "<leader>cR",
				},
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

				-- UML related prompts
				PlantUMLClassDiagram = "Please generate a UML class diagram for the following code using PlantUML.",
				PlantUMLSequenceDiagram = "Please generate a UML sequence diagram for the following code using PlantUML.",
				PlantUMLUseCaseDiagram = "Please generate a UML use case diagram for the following code using PlantUML.",
				PlantUMLActivityDiagram = "Please generate a UML activity diagram for the following code using PlantUML.",
				PlantUMLComponentDiagram = "Please generate a UML component diagram for the following code using PlantUML.",
				PlantUMLDeploymentDiagram = "Please generate a UML deployment diagram for the following code using PlantUML.",
				PlantUMLStateDiagram = "Please generate a UML state diagram for the following code using PlantUML.",
				PlantUMLObjectDiagram = "Please generate a UML object diagram for the following code using PlantUML.",
				PlantUMLPackageDiagram = "Please generate a UML package diagram for the following code using PlantUML.",
				PlantUMLCompositeStructureDiagram = "Please generate a UML composite structure diagram for the following code using PlantUML.",

				-- Data Structure related prompts
				AnalyzeAlgorithm = "Please analyze the following data structure algorithm and suggest the most efficient approach for time-complexity and space-complexity using Javascript.",
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
				system_prompt = {
					normal = "gp",
				},
				user_selection = {
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
				"<leader>cl",
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
					require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Help actions",
				mode = { "n", "v" },
			},
			{
				"<leader>cp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
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
