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
		lazy = true,
		opts = {
			debug = false,
			model = "claude-3.7-sonnet-thought",
			show_help = "yes",
			language = "English",
			prompts = {
				-- Code related prompts
				Explain = {
					prompt = "Please explain how the following code works.",
					context = { "selection", "vectorcode", "buffers" },
				},
				Review = {
					prompt = "Please perform a detailed review of the following code, including suggestions for improvement, potential bugs, and adherence to best practices.",
					mapping = "<leader>cr",
					context = { "selection", "vectorcode", "buffers" },
				},
				Tests = {
					mapping = "<leader>ct",
					prompt = "Please explain how the selected code works, then generate a comprehensive suite of unit tests for it. Ensure the tests cover a wide range of scenarios, including edge cases, exception handling, and data validation.",
					context = { "selection", "vectorcode", "buffers" },
				},
				Refactor = {
					prompt = "Please refactor the following code to improve its clarity and readability.",
					mapping = "<leader>cR",
					context = { "selection", "vectorcode", "buffers" },
				},
				FixCode = {
					prompt = "Please fix the following code to make it work as intended.",
					context = { "selection", "vectorcode", "buffers" },
				},
				FixError = {
					prompt = "Please explain the error in the following text and provide a solution.",
					context = { "selection", "diagnostics", "vectorcode", "buffers" },
				},
				BetterNamings = {
					prompt = "Please provide better names for the following variables and functions.",
					context = { "selection", "vectorcode", "buffers" },
				},
				Documentation = {
					prompt = "Please provide documentation for the following code.",
					context = { "selection", "vectorcode", "buffers" },
				},
				SwaggerApiDocs = {
					prompt = "Please provide documentation for the following API using Swagger.",
					context = { "selection", "vectorcode", "buffers" },
				},
				SwaggerJsDocs = {
					prompt = "Please write JSDoc for the following API using Swagger.",
					context = { "selection", "vectorcode", "buffers" },
				},
				-- Text related prompts
				Summarize = "Please summarize the following text.",
				Spelling = "Please correct any grammar and spelling errors in the following text.",
				Wording = "Please improve the grammar and wording of the following text.",
				Concise = "Please rewrite the following text to make it more concise.",

				-- UML related prompts
				PlantUMLClassDiagram = {
					prompt = "Please generate a UML class diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLSequenceDiagram = {
					prompt = "Please generate a UML sequence diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLUseCaseDiagram = {
					prompt = "Please generate a UML use case diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLActivityDiagram = {
					prompt = "Please generate a UML activity diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLComponentDiagram = {
					prompt = "Please generate a UML component diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLDeploymentDiagram = {
					prompt = "Please generate a UML deployment diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLStateDiagram = {
					prompt = "Please generate a UML state diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLObjectDiagram = {
					prompt = "Please generate a UML object diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLPackageDiagram = {
					prompt = "Please generate a UML package diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},
				PlantUMLCompositeStructureDiagram = {
					prompt = "Please generate a UML composite structure diagram for the following code using PlantUML.",
					context = { "selection", "vectorcode" },
				},

				-- Data Structure related prompts
				AnalyzeAlgorithm = {
					prompt = "Please analyze the following data structure algorithm and suggest the most efficient approach for time-complexity and space-complexity using Javascript.",
					context = { "selection", "vectorcode" },
				},
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
				"<leader>cD",
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
			-- {
			-- 	"<leader>cv",
			-- 	"<cmd>CopilotChatVsplitToggle<cr>",
			-- 	desc = "CopilotChat - Toggle vertical split",
			-- 	mode = { "n", "v" },
			-- },
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
			-- {
			-- 	"<leader>co",
			-- 	"<cmd>CopilotChatOptimize<cr>",
			-- 	desc = "CopilotChat - Optimize code",
			-- 	mode = { "n", "v" },
			-- },
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
			-- {
			-- 	"<leader>cq",
			-- 	function()
			-- 		local input = vim.fn.input("Ask Copilot: ")
			-- 		if input ~= "" then
			-- 			vim.cmd("CopilotChat " .. input)
			-- 		end
			-- 	end,
			-- 	desc = "CopilotChat - Ask input",
			-- 	mode = { "n", "v", "x" },
			-- },
		},
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
			{ "Davidyz/VectorCode" },
		},
		config = function(_, opts)
			local success_copilot, chat = pcall(require, "CopilotChat")
			if success_copilot then
				-- Set up VectorCode context provider
				local success_vectorcode, vectorcode = pcall(require, "vectorcode")
				local vectorcode_ctx = {}

				if success_vectorcode then
					vectorcode_ctx = vectorcode.integrations.copilotchat.make_context_provider({
						prompt_header = "Here are relevant files from the repository:", -- Customize header text
						prompt_footer = "\nConsider this context when answering:", -- Customize footer text
						skip_empty = true, -- Skip adding context when no files are retrieved
					})
				end

				-- Add the context provider to opts
				opts.contexts = opts.contexts or {}
				opts.contexts.vectorcode = vectorcode_ctx

				chat.setup(opts)
			else
				print("Error: CopilotChat module not found")
			end
		end,
	},
}
