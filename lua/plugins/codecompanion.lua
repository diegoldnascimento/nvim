return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: for completion
			"nvim-telescope/telescope.nvim", -- Optional: for actions
			{
				"stevearc/dressing.nvim", -- Optional: for better UI
				opts = {},
			},
		},
		config = function()
			-- Get Anthropic API key from environment variable
			local api_key = os.getenv("ANTHROPIC_API_KEY")
			if not api_key then
				vim.notify("Warning: ANTHROPIC_API_KEY environment variable not set", vim.log.levels.WARN)
				return
			end

			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "anthropic",
					},
					inline = {
						adapter = "anthropic",
					},
				},
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = api_key,
							},
							schema = {
								model = {
									default = "claude-sonnet-4-20250514",
								},
							},
						})
					end,
				},
				prompt_library = {
					-- Code related prompts
					["Explain Code"] = {
						strategy = "chat",
						description = "Explain how the selected code works",
						opts = {
							mapping = "<leader>ce",
							modes = { "v" },
							slash_cmd = "explain",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please explain how the following code works:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Code Review"] = {
						strategy = "chat",
						description = "Perform a detailed code review",
						opts = {
							mapping = "<leader>cr",
							modes = { "v" },
							slash_cmd = "review",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please perform a detailed review of the following code, including suggestions for improvement, potential bugs, and adherence to best practices:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Generate Tests"] = {
						strategy = "chat",
						description = "Generate comprehensive unit tests",
						opts = {
							mapping = "<leader>ct",
							modes = { "v" },
							slash_cmd = "tests",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please explain how the selected code works, then generate a comprehensive suite of unit tests for it. Ensure the tests cover a wide range of scenarios, including edge cases, exception handling, and data validation:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Refactor Code"] = {
						strategy = "chat",
						description = "Refactor code for clarity and readability",
						opts = {
							mapping = "<leader>cR",
							modes = { "v" },
							slash_cmd = "refactor",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please refactor the following code to improve its clarity and readability. Explain the changes and reasoning behind the choices:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Fix Code"] = {
						strategy = "chat",
						description = "Fix code to work as intended",
						opts = {
							slash_cmd = "fix",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please fix the following code to make it work as intended:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Fix Error"] = {
						strategy = "chat",
						description = "Explain error and provide solution",
						opts = {
							mapping = "<leader>cf",
							slash_cmd = "fixerror",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please explain the error in the following text and provide a solution:\n\n```{{filetype}}\n{{selection}}\n```\n\nDiagnostics: {{diagnostics}}",
							},
						},
					},
					["Better Naming"] = {
						strategy = "chat",
						description = "Suggest better variable and function names",
						opts = {
							slash_cmd = "naming",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please provide better names for the following variables and functions:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Generate Documentation"] = {
						strategy = "chat",
						description = "Generate documentation for code",
						opts = {
							mapping = "<leader>cD",
							modes = { "v" },
							slash_cmd = "docs",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please provide documentation for the following code:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Swagger API Docs"] = {
						strategy = "chat",
						description = "Generate Swagger API documentation",
						opts = {
							slash_cmd = "swagger",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please provide documentation for the following API using Swagger:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["JSDoc Documentation"] = {
						strategy = "chat",
						description = "Generate JSDoc documentation",
						opts = {
							slash_cmd = "jsdoc",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please write JSDoc for the following API using Swagger:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					-- Text related prompts
					["Summarize Text"] = {
						strategy = "chat",
						description = "Summarize the selected text",
						opts = {
							slash_cmd = "summarize",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please summarize the following text:\n\n{{selection}}",
							},
						},
					},
					["Fix Spelling"] = {
						strategy = "chat",
						description = "Correct grammar and spelling errors",
						opts = {
							slash_cmd = "spelling",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please correct any grammar and spelling errors in the following text:\n\n{{selection}}",
							},
						},
					},
					["Improve Wording"] = {
						strategy = "chat",
						description = "Improve grammar and wording",
						opts = {
							slash_cmd = "wording",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please improve the grammar and wording of the following text:\n\n{{selection}}",
							},
						},
					},
					["Make Concise"] = {
						strategy = "chat",
						description = "Make text more concise",
						opts = {
							slash_cmd = "concise",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please rewrite the following text to make it more concise:\n\n{{selection}}",
							},
						},
					},
					-- UML related prompts
					["PlantUML Class Diagram"] = {
						strategy = "chat",
						description = "Generate UML class diagram",
						opts = {
							slash_cmd = "class",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please generate a UML class diagram for the following code using PlantUML:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["PlantUML Sequence Diagram"] = {
						strategy = "chat",
						description = "Generate UML sequence diagram",
						opts = {
							slash_cmd = "sequence",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please generate a UML sequence diagram for the following code using PlantUML:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["PlantUML Use Case Diagram"] = {
						strategy = "chat",
						description = "Generate UML use case diagram",
						opts = {
							slash_cmd = "usecase",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please generate a UML use case diagram for the following code using PlantUML:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["PlantUML Activity Diagram"] = {
						strategy = "chat",
						description = "Generate UML activity diagram",
						opts = {
							slash_cmd = "activity",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please generate a UML activity diagram for the following code using PlantUML:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					["Algorithm Analysis"] = {
						strategy = "chat",
						description = "Analyze algorithm complexity",
						opts = {
							slash_cmd = "analyze",
							auto_submit = true,
						},
						prompts = {
							{
								role = "user",
								content = "Please analyze the following data structure algorithm and suggest the most efficient approach for time-complexity and space-complexity using Javascript:\n\n```{{filetype}}\n{{selection}}\n```",
							},
						},
					},
					-- Git related prompts
					["Git Code Review"] = {
						strategy = "chat",
						description = "Review git changes with detailed feedback",
						opts = {
							mapping = "<leader>cG",
							slash_cmd = "gitreview",
						},
						prompts = {
							{
								role = "user",
								content = function()
									-- Get git diff
									local diff_handle = io.popen("git diff")
									local diff = diff_handle and diff_handle:read("*a") or "Error retrieving git diff"
									if diff_handle then
										diff_handle:close()
									end

									-- Get last 3 commits
									local commits_handle = io.popen("git log --oneline -n 3")
									local commits = commits_handle and commits_handle:read("*a")
										or "Error retrieving commits"
									if commits_handle then
										commits_handle:close()
									end

									-- Get current branch name
									local base_branch_handle = io.popen(
										"git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null || echo 'origin/main'"
									)
									local base_branch = base_branch_handle
											and base_branch_handle:read("*a"):gsub("^refs/remotes/", ""):gsub("%s+$", "")
										or "origin/main"
									if base_branch_handle then
										base_branch_handle:close()
									end

									-- Get current branch
									local branch_handle = io.popen("git rev-parse --abbrev-ref HEAD")
									local branch = branch_handle and branch_handle:read("*a"):gsub("%s+$", "")
										or "unknown"
									if branch_handle then
										branch_handle:close()
									end

									-- Get changed file paths
									local compare_with = branch == base_branch:gsub("^origin/", "") and "HEAD~1"
										or base_branch
									local path_handle =
										io.popen("git diff --name-only " .. vim.fn.shellescape(compare_with))
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
											full_context = full_context
												.. "\n\n## File: "
												.. path
												.. "\n(Could not read file)"
										end
									end

									-- Build the prompt
									return string.format(
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
								end,
							},
						},
					},
					["Generate Pull Request"] = {
						strategy = "chat",
						description = "Generate a pull request description",
						opts = {
							mapping = "<leader>cP",
							slash_cmd = "pullrequest",
						},
						prompts = {
							{
								role = "user",
								content = function()
									-- Get git diff
									local diff_handle = io.popen("git diff")
									local diff = diff_handle and diff_handle:read("*a") or "Error retrieving git diff"
									if diff_handle then
										diff_handle:close()
									end

									return "Generate a detailed pull request description using the following template:\n## Title(Generate a PR title)\n## Context(Why is this change being made?)\n## Description(What was done in this pull request?)\n## Functional Summary(Short functional summary)\n## Code Changes(Summarize the technical changes made.)\n## Tests(What tests were added or changed?)\n## QA Steps(What are the steps to reproduce the fix)\n## Risks(What could potentially break or require attention?)\n\nGit diff:\n"
										.. diff
								end,
							},
						},
					},
				},
				display = {
					action_palette = {
						width = 95,
						height = 10,
					},
					chat = {
						window = {
							layout = "vertical", -- float|vertical|horizontal|buffer
							width = 0.45,
							height = 0.4,
							relative = "editor",
							border = "single",
							title = "CodeCompanion",
							zindex = 45,
						},
						intro_message = "Welcome! I'm Claude, powered by CodeCompanion. How can I help you with your code today?",
						show_settings = true,
					},
				},
				opts = {
					log_level = "INFO", -- TRACE|DEBUG|ERROR|INFO
					send_code = true, -- Send code context to LLM
				},
			})
		end,
		event = "VeryLazy",
		keys = {
			-- Chat commands
			{
				"<leader>cc",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "CodeCompanion - Toggle chat",
				mode = { "n", "v" },
			},
			{
				"<leader>cb",
				"<cmd>CodeCompanionChat Add<cr>",
				desc = "CodeCompanion - Add current buffer to chat",
				mode = { "n", "v" },
			},
			{
				"<leader>ce",
				"<cmd>CodeCompanion /explain<cr>",
				desc = "CodeCompanion - Explain code",
				mode = { "v" },
			},
			{
				"<leader>cr",
				"<cmd>CodeCompanion /review<cr>",
				desc = "CodeCompanion - Review code",
				mode = { "v" },
			},
			{
				"<leader>ct",
				"<cmd>CodeCompanion /tests<cr>",
				desc = "CodeCompanion - Generate tests",
				mode = { "v" },
			},
			{
				"<leader>cR",
				"<cmd>CodeCompanion /refactor<cr>",
				desc = "CodeCompanion - Refactor code",
				mode = { "v" },
			},
			{
				"<leader>cD",
				"<cmd>CodeCompanion /docs<cr>",
				desc = "CodeCompanion - Generate docs",
				mode = { "v" },
			},
			{
				"<leader>cf",
				"<cmd>CodeCompanion /fixerror<cr>",
				desc = "CodeCompanion - Fix diagnostic",
				mode = { "n", "v" },
			},
			{
				"<leader>cG",
				"<cmd>CodeCompanion /gitreview<cr>",
				desc = "CodeCompanion - Git code review",
				mode = { "n" },
			},
			{
				"<leader>cP",
				"<cmd>CodeCompanion /pullrequest<cr>",
				desc = "CodeCompanion - Generate PR description",
				mode = { "n" },
			},
			-- Action palette
			{
				"<leader>cp",
				"<cmd>CodeCompanionActions<cr>",
				desc = "CodeCompanion - Action palette",
				mode = { "n", "v" },
			},
			{
				"<leader>ch",
				"<cmd>CodeCompanionActions<cr>",
				desc = "CodeCompanion - Action palette",
				mode = { "n", "v" },
			},
			-- Quick chat
			{
				"<leader>cq",
				function()
					vim.ui.input({ prompt = "Quick Chat: " }, function(input)
						if input and input ~= "" then
							require("codecompanion").prompt(input)
						end
					end)
				end,
				desc = "CodeCompanion - Quick chat",
				mode = { "n", "v" },
			},
			-- Clear chat
			{
				"<leader>cl",
				"<cmd>CodeCompanionChat Reset<cr>",
				desc = "CodeCompanion - Reset chat",
				mode = { "n", "v" },
			},
		},
	},
}
