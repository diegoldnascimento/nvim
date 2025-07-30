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
			model = "claude-sonnet-4",
			show_help = "yes",
			language = "English",
			prompts = {
				-- Code related prompts
				Explain = {
					prompt = "Please explain how the following code works.",
					context = { "selection", "buffers" },
				},
				Review = {
					prompt = "Please perform a detailed review of the following code, including suggestions for improvement, potential bugs, and adherence to best practices.",
					mapping = "<leader>cr",
					context = { "selection", "buffers" },
				},
				Tests = {
					mapping = "<leader>ct",
					prompt = "Please explain how the selected code works, then generate a comprehensive suite of unit tests for it. Ensure the tests cover a wide range of scenarios, including edge cases, exception handling, and data validation.",
					context = { "selection", "buffers" },
				},
				Refactor = {
					prompt = "Please refactor the following code to improve its clarity and readability. Explain the following changes and reasoning behind the choices",
					mapping = "<leader>cR",
					context = { "selection", "buffers" },
				},
				FixCode = {
					prompt = "Please fix the following code to make it work as intended.",
					context = { "selection", "buffers" },
				},
				FixError = {
					prompt = "Please explain the error in the following text and provide a solution.",
					context = { "selection", "diagnostics", "buffers" },
				},
				BetterNamings = {
					prompt = "Please provide better names for the following variables and functions.",
					context = { "selection", "buffers" },
				},
				Documentation = {
					prompt = "Please provide documentation for the following code.",
					context = { "selection", "buffers" },
				},
				SwaggerApiDocs = {
					prompt = "Please provide documentation for the following API using Swagger.",
					context = { "selection", "buffers" },
				},
				SwaggerJsDocs = {
					prompt = "Please write JSDoc for the following API using Swagger.",
					context = { "selection", "buffers" },
				},
				-- Text related prompts
				Summarize = "Please summarize the following text.",
				Spelling = "Please correct any grammar and spelling errors in the following text.",
				Wording = "Please improve the grammar and wording of the following text.",
				Concise = "Please rewrite the following text to make it more concise.",

				-- UML related prompts
				PlantUMLClassDiagram = {
					prompt = "Please generate a UML class diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLSequenceDiagram = {
					prompt = "Please generate a UML sequence diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLUseCaseDiagram = {
					prompt = "Please generate a UML use case diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLActivityDiagram = {
					prompt = "Please generate a UML activity diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLComponentDiagram = {
					prompt = "Please generate a UML component diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLDeploymentDiagram = {
					prompt = "Please generate a UML deployment diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLStateDiagram = {
					prompt = "Please generate a UML state diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLObjectDiagram = {
					prompt = "Please generate a UML object diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLPackageDiagram = {
					prompt = "Please generate a UML package diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				PlantUMLCompositeStructureDiagram = {
					prompt = "Please generate a UML composite structure diagram for the following code using PlantUML.",
					context = { "selection" },
				},
				-- Data Structure related prompts
				AnalyzeAlgorithm = {
					prompt = "Please analyze the following data structure algorithm and suggest the most efficient approach for time-complexity and space-complexity using Javascript.",
					context = { "selection" },
				},

				-- Git related prompts
				GitCodeReview = {
					prompt = "Perform a comprehensive code review of the git changes.",
					mapping = "<leader>cG",
					context = { "git" },
					description = "Review git changes with detailed feedback",
					callback = function()
						return require("CopilotChat").integrations.actions.run_git_code_review()
					end,
				},
				GitGeneratePullRequest = {
					prompt = "Generate a detailed pull request description using the following template:\n### Title(A concise one-line summary of the change)\n### Context(Why is this change being made?)\n### Description(What was done in this pull request?)\n### Code Changes(Summarize the technical changes made and include the path of the changes.)\n### Tests(What tests were added or changed?)\n### Risks(What could potentially break or require attention?) \nUse the provided git diff to create a comprehensive description with accurate technical details.]]",
					mapping = "<leader>cP",
					context = { "git" },
					description = "Generate a pull request description",
					callback = function()
						return require("CopilotChat").integrations.actions.generate_pull_request()
					end,
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
			{
				"<leader>cP",
				"<cmd>CopilotChatGeneratePullRequest<cr>",
				desc = "CopilotChat - Generate PR Description",
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
		},
		config = function(_, opts)
			local success_copilot, chat = pcall(require, "CopilotChat")
			if success_copilot then
				chat.setup(opts)

				-- Create CopilotChat integrations namespace if it doesn't exist
				if not chat.integrations then
					chat.integrations = {}
				end

				-- Create actions module if it doesn't exist
				if not chat.integrations.actions then
					chat.integrations.actions = {}
				end

				-- Implement the git code review function
				chat.integrations.actions.run_git_code_review = function()
					-- Get git diff
					local diff_handle = io.popen("git diff")
					local diff = diff_handle and diff_handle:read("*a") or "Error retrieving git diff"
					if diff_handle then
						diff_handle:close()
					end

					-- Get last 3 commits
					local commits_handle = io.popen("git log --oneline -n 3")
					local commits = commits_handle and commits_handle:read("*a") or "Error retrieving commits"
					if commits_handle then
						commits_handle:close()
					end

					-- Get current branch name
					local base_branch_handle =
						io.popen("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null || echo 'origin/main'")
					local base_branch = base_branch_handle
							and base_branch_handle:read("*a"):gsub("^refs/remotes/", ""):gsub("%s+$", "")
						or "origin/main"
					if base_branch_handle then
						base_branch_handle:close()
					end

					-- Get current branch
					local branch_handle = io.popen("git rev-parse --abbrev-ref HEAD")
					local branch = branch_handle and branch_handle:read("*a"):gsub("%s+$", "") or "unknown"
					if branch_handle then
						branch_handle:close()
					end
					-- Get changed file paths
					local compare_with = branch == base_branch:gsub("^origin/", "") and "HEAD~1"
						or base_branch
					local path_handle = io.popen("git diff --name-only " .. vim.fn.shellescape(compare_with))
					local files_raw = path_handle and path_handle:read("*a") or ""
					if path_handle then
						path_handle:close()
					end

					local file_paths = {}
					for file in string.gmatch(files_raw, "[^\r\n]+") do
						table.insert(file_paths, file)
					end

					-- Read full contents of changed files
					local full_context = ""
					for _, path in ipairs(file_paths) do
						local f = io.open(path, "r")
						if f then
							local content = f:read("*a")
							f:close()
							full_context = full_context
								.. "\n\n## File: "
								.. path
								.. "\n```ts\n"
								.. content
								.. "\n```"
						else
							full_context = full_context .. "\n\n## File: " .. path .. "\n(Could not read file)"
						end
					end

					-- Build the prompt
					local prompt = string.format(
						[[
              You are a senior software engineer performing a pull request code review.

              ## Branch
              %s

              ## Recent Commits
              %s

              ## Git Diff
              %s

              ## Full Context
              %s

              Please provide a comprehensive code review with the following structure:
              1. **Overview**: Brief summary of the changes
              2. **Positive Aspects**: What looks good in the implementation
              3. **Issues and Suggestions**: Specific problems found with line references and suggested fixes
              4. **Performance Considerations**: Any potential performance impacts
              5. **Security Considerations**: Any security implications
              6. **Testing Considerations**: What should be tested to verify these changes
              7. **Conclusion**: Overall assessment and recommendation (approve/request changes)

              Focus particularly on:
              - Code correctness and potential bugs
              - Error handling robustness
              - Adherence to project patterns and best practices
              - Edge cases that might not be handled

              Now provide a code review focusing on quality, bugs, and improvements.
            ]],
						branch,
						commits,
						diff,
						full_context
					)

					return prompt
				end
                
                -- Implement the pull request generator function
				chat.integrations.actions.generate_pull_request = function()
					-- Get git diff
					local diff_handle = io.popen("git diff")
					local diff = diff_handle and diff_handle:read("*a") or "Error retrieving git diff"
					if diff_handle then
						diff_handle:close()
					end

					local prompt = [[Generate a detailed pull request description using the following template:
## Title(Generate a PR title)
## Context(Why is this change being made?)
## Description(What was done in this pull request?)
## Functional Summary(Short functional summary) 
## Code Changes(Summarize the technical changes made.)
## Tests(What tests were added or changed?)
## QA Steps(What are the steps to reproduce the htofix)
## Risks(What could potentially break or require attention?)
Git diff:]] .. diff

					return prompt
				end
			else
				print("Error: CopilotChat module not found")
			end

			-- Preserve the original commands for backward compatibility
			vim.api.nvim_create_user_command("CopilotGitCodeReview", function()
				-- Call the integrations function directly
				local prompt = require("CopilotChat").integrations.actions.run_git_code_review()
				require("CopilotChat").ask(prompt)
			end, {})
			
			vim.api.nvim_create_user_command("CopilotChatGeneratePullRequest", function()
				-- Call the integrations function directly
				local prompt = require("CopilotChat").integrations.actions.generate_pull_request()
				require("CopilotChat").ask(prompt)
			end, {})
		end,
	},
}
