-- =============================================================================
-- Avante.nvim Configuration
-- Ported from CodeCompanion.nvim with all custom prompts, shortcuts, and keybindings
-- =============================================================================

return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Never set this to "*" - use latest commit
		build = "make", -- For Linux/Mac. For Windows: "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Optional dependencies
			"nvim-telescope/telescope.nvim", -- For file_selector provider telescope
			"hrsh7th/nvim-cmp", -- Autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- For file_selector provider fzf
			"echasnovski/mini.pick", -- For file_selector provider mini.pick
			"nvim-tree/nvim-web-devicons", -- Or echasnovski/mini.icons
			{
				"stevearc/dressing.nvim", -- For better UI
				opts = {},
			},
			{
				"HakonHarnes/img-clip.nvim", -- Support for image pasting
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim", -- Markdown rendering
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},

		---@module 'avante'
		---@type avante.Config
		opts = {
			-- =================================================================
			-- Provider Configuration
			-- =================================================================
			provider = "claude",
			providers = {
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					timeout = 30000,
					extra_request_body = {
						temperature = 0.7,
						max_tokens = 20480,
					},
				},
			},

			-- =================================================================
			-- Behavior Settings
			-- =================================================================
			behaviour = {
				auto_focus_sidebar = true,
				auto_suggestions = false,
				auto_apply_diff_after_generation = false,
				auto_set_keymaps = true,
				auto_set_highlight_group = true,
				jump_result_buffer_on_finish = false,
				support_paste_from_clipboard = true,
				minimize_diff = true,
				enable_token_counting = true,
				auto_approve_tool_permissions = false,
			},

			-- =================================================================
			-- Instructions File (project-specific context)
			-- =================================================================
			instructions_file = "GEMINI.md",

			-- =================================================================
			-- Rules Configuration (for .avanterules files)
			-- =================================================================
			rules = {
				project_dir = ".avante/rules",
				global_dir = "~/.config/avante/rules",
			},

			-- =================================================================
			-- Window Configuration
			-- =================================================================
			windows = {
				position = "right",
				wrap = true,
				width = 40,
				sidebar_header = {
					enabled = true,
					align = "center",
					rounded = true,
				},
				input = {
					prefix = "> ",
					height = 8,
				},
				edit = {
					border = "rounded",
					start_insert = true,
				},
				ask = {
					floating = false,
					start_insert = true,
					border = "rounded",
					focus_on_apply = "ours",
				},
			},

			-- =================================================================
			-- File Selector Configuration
			-- =================================================================
			file_selector = {
				provider = "telescope",
				provider_opts = {},
			},

			-- =================================================================
			-- Input Configuration
			-- =================================================================
			input = {
				provider = "native",
				provider_opts = {},
			},

			-- =================================================================
			-- Suggestion Configuration
			-- =================================================================
			suggestion = {
				debounce = 600,
				throttle = 600,
			},

			-- =================================================================
			-- Keymappings
			-- =================================================================
			mappings = {
				-- Main keybindings (used in hints and default mappings)
				ask = "<leader>aa",
				edit = "<leader>ae",
				refresh = "<leader>ar",

				-- Diff-related keybindings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]c",
					prev = "[c",
				},

				-- Suggestion keybindings
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},

				-- Jump between code blocks
				jump = {
					next = "]]",
					prev = "[[",
				},

				-- Submit with Ctrl+Enter
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},

				-- Cancel current request
				cancel = {
					normal = { "<C-c>", "q" },
					insert = "<C-c>",
				},

				-- Sidebar keybindings
				sidebar = {
					apply_all = "A",
					apply_cursor = "a",
					retry = "r",
					edit = "e",
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
					remove_file = "d",
					add_file = "@",
					close = { "<Esc>", "q" },
					close_from_input = nil,
				},

				-- Files section
				files = {
					add_current = "<leader>.",
				},
			},

			-- =================================================================
			-- Hints Configuration
			-- =================================================================
			hints = {
				enabled = true,
			},

			-- =================================================================
			-- Shortcuts (accessible via # in input)
			-- Ported from CodeCompanion prompt_library
			-- =================================================================
			shortcuts = {
				-- Code Analysis & Explanation
				{
					name = "explain",
					description = "Explain how the selected code works",
					prompt = [[Please explain how the following code works:

Focus on:
- The main purpose and algorithm
- Key data structures and design patterns used
- Time/space complexity if relevant
- How it handles edge cases
- Integration points with other code

Provide a clear explanation that would help a mid-level developer understand the implementation.]],
				},

				-- Code Quality & Review
				{
					name = "review",
					description = "Perform a detailed code review",
					prompt = [[Please perform a comprehensive code review:

Review checklist:
- [ ] **Correctness**: Logic errors, boundary conditions, null handling
- [ ] **Performance**: Algorithmic complexity, database queries, caching opportunities
- [ ] **Security**: Input validation, authentication, data sanitization
- [ ] **Maintainability**: Code clarity, naming, structure
- [ ] **Error Handling**: Exception handling, error messages, recovery
- [ ] **Testing**: What tests are needed, edge cases to cover
- [ ] **Documentation**: Missing docs, unclear sections

Format your review as:
1. **Critical Issues** (must fix)
2. **Important Suggestions** (should fix)
3. **Minor Improvements** (consider fixing)
4. **Positive Aspects** (what's done well)

Provide specific line references and code examples for suggested changes.]],
				},

				-- Security Audit
				{
					name = "security",
					description = "Perform security analysis",
					prompt = [[Perform a comprehensive security audit:

Analyze for:
- **Injection vulnerabilities**: SQL, NoSQL, Command, LDAP injection
- **Authentication & Authorization**: Weak auth, privilege escalation
- **Data Exposure**: Sensitive data leaks, improper encryption
- **XSS & CSRF**: Cross-site scripting and request forgery
- **Input Validation**: Unsafe input handling, buffer overflows
- **Configuration Security**: Hardcoded secrets, weak configs
- **Dependencies**: Known vulnerable libraries

For each issue found:
1. **Severity**: Critical/High/Medium/Low
2. **Description**: What's the vulnerability
3. **Impact**: What could an attacker do
4. **Remediation**: Specific fix with code example
5. **Prevention**: How to avoid similar issues

Include CWE/CVE references where applicable.]],
				},

				-- Testing
				{
					name = "tests",
					description = "Generate comprehensive unit tests",
					prompt = [[Generate comprehensive tests for this code:

Requirements:
1. **Framework**: Use the appropriate testing framework for this language
2. **Coverage Types**:
   - Happy path scenarios
   - Edge cases (null, empty, boundary values)
   - Error scenarios and exception handling
   - Concurrent access if applicable
   - Performance constraints if relevant
3. **Test Structure**:
   - Descriptive names: should_expectedBehavior_when_condition
   - Proper setup/teardown
   - Test isolation (no dependencies between tests)
   - Mock external dependencies
4. **Assertions**: Comprehensive, specific assertions
5. **Documentation**: Comment complex test scenarios

Target: >80% code coverage with meaningful tests

Provide complete, runnable test code with all necessary imports and setup.]],
				},

				-- Refactoring & Optimization
				{
					name = "refactor",
					description = "Refactor code for clarity and maintainability",
					prompt = [[Refactor this code for improved clarity and maintainability:

Requirements:
- Apply SOLID principles and design patterns where appropriate
- Improve naming for clarity and expressiveness
- Reduce complexity and improve readability
- Extract methods/functions for reusability
- Follow language idioms and best practices
- Preserve all existing functionality
- Add explanatory comments for complex logic

Output format:
1. **Refactored Code** (ready to paste)
2. **Change Summary** (what was changed)
3. **Justification** (why each change improves the code)
4. **Metrics** (complexity reduction, lines saved, etc.)

Ensure the refactored code is production-ready and well-structured.]],
				},

				-- Performance Optimization
				{
					name = "optimize",
					description = "Optimize code performance",
					prompt = [[Analyze and optimize the performance of this code:

Analysis areas:
1. **Time Complexity**: Current vs. optimized Big-O
2. **Space Complexity**: Memory usage optimization
3. **Database/IO**: Query optimization, batching, caching
4. **Algorithmic**: Better algorithms or data structures
5. **Parallelization**: Async/concurrent processing opportunities
6. **Caching**: Strategic caching points

For each optimization:
- **Current Issue**: What's slow and why
- **Proposed Solution**: Specific optimization
- **Performance Gain**: Expected improvement (with metrics)
- **Trade-offs**: Any downsides to consider
- **Implementation**: Optimized code

Provide benchmarks or complexity analysis to justify changes.]],
				},

				-- Error Handling & Debugging
				{
					name = "fix",
					description = "Fix code to work as intended",
					prompt = [[Please analyze and fix the following code:

Provide:
1. **Issue Identification**: What's wrong with the current code
2. **Root Cause Analysis**: Why the issue occurs
3. **Fixed Code**: Complete corrected version (ready to paste)
4. **Explanation**: Detailed explanation of changes
5. **Test Cases**: How to verify the fix works
6. **Prevention Tips**: How to avoid this issue in the future

Ensure the fix is robust and handles edge cases properly.]],
				},

				{
					name = "fixerror",
					description = "Explain error and provide solution",
					prompt = [[Analyze and fix this error:

Please provide:
1. **Error Explanation**: What the error means in simple terms
2. **Root Cause**: Why this error is occurring
3. **Solution**: Fixed code with the error resolved
4. **Alternative Approaches**: Other ways to solve this
5. **Related Issues**: Common related problems to watch for
6. **Best Practices**: How to prevent similar errors

Make sure the solution is production-ready and well-tested.]],
				},

				-- Code Quality Improvements
				{
					name = "naming",
					description = "Suggest better variable and function names",
					prompt = [[Improve naming in this code for better readability:

Guidelines:
- Use descriptive, self-documenting names
- Follow language naming conventions
- Avoid abbreviations unless widely understood
- Use names that reveal intent
- Consider the domain context

Provide:
1. **Current → Suggested** name mappings
2. **Reasoning** for each change
3. **Refactored code** with new names
4. **Impact analysis** on readability

Focus on making the code more maintainable and easier to understand.]],
				},

				-- Documentation
				{
					name = "docs",
					description = "Generate comprehensive documentation",
					prompt = [[Generate comprehensive documentation for this code:

Include:
1. **Overview**: Purpose, use cases, and design decisions
2. **API Reference**:
   - Function/method signatures
   - Parameters (types, constraints, defaults, required/optional)
   - Return values (type, structure, possible values)
   - Exceptions/errors (when thrown, how to handle)
   - Side effects
3. **Usage Examples**: 
   - Basic usage
   - Advanced scenarios
   - Common patterns
   - Error handling examples
4. **Performance Notes**: Complexity, optimization tips
5. **Dependencies**: External requirements, version constraints
6. **Changelog**: Version history if applicable

Use the appropriate documentation format for this language (JSDoc, docstrings, etc.).
Ensure documentation is complete, accurate, and helpful for developers.]],
				},

				{
					name = "swagger",
					description = "Generate Swagger/OpenAPI documentation",
					prompt = [[Generate complete Swagger/OpenAPI documentation:

Include:
1. **Endpoint definitions**: paths, methods, operations
2. **Request specifications**:
   - Parameters (path, query, header, body)
   - Request body schemas
   - Content types
3. **Response specifications**:
   - Status codes with descriptions
   - Response schemas
   - Error responses
4. **Security definitions**: Authentication/authorization
5. **Examples**: Request/response examples
6. **Models/Schemas**: Data model definitions

Follow OpenAPI 3.0+ specification.
Include descriptions, examples, and constraints for all fields.
Make it ready for Swagger UI consumption.]],
				},

				{
					name = "jsdoc",
					description = "Generate complete JSDoc documentation",
					prompt = [[Generate comprehensive JSDoc documentation:

Requirements:
- Complete type annotations using JSDoc syntax
- @param with types, descriptions, and optional/default indicators
- @returns with type and description
- @throws for exceptions
- @example with practical usage
- @since, @deprecated, @see as appropriate
- @typedef for complex types
- Class documentation with @class, @constructor
- Method documentation with full details

Make it IntelliSense-friendly and comprehensive.]],
				},

				-- Type Conversion
				{
					name = "typescript",
					description = "Convert JavaScript to TypeScript with full types",
					prompt = [[Convert to TypeScript with comprehensive type safety:

Requirements:
1. **Type Annotations**: Add types to all variables, parameters, returns
2. **Interfaces/Types**: Create appropriate type definitions
3. **Generics**: Use where beneficial for reusability
4. **Strict Mode**: Ensure compatibility with strict TypeScript settings
5. **Type Guards**: Add runtime type checking where needed
6. **Enums/Constants**: Convert magic values to enums
7. **Utility Types**: Use built-in TypeScript utilities

Maintain all functionality while maximizing type safety.
Follow TypeScript best practices and conventions.
Make the code more maintainable and self-documenting.]],
				},

				-- Text Processing
				{
					name = "summarize",
					description = "Create a concise summary",
					prompt = [[Summarize the following text concisely:

Provide:
1. **Key Points**: Main ideas in bullet form
2. **Brief Summary**: 2-3 sentence overview
3. **Action Items**: If any are mentioned
4. **Important Details**: Critical information to remember

Keep the summary clear, accurate, and actionable.]],
				},

				{
					name = "spelling",
					description = "Correct grammar and spelling errors",
					prompt = [[Correct grammar and spelling errors:

Fix all:
- Spelling mistakes
- Grammar errors
- Punctuation issues
- Capitalization errors

Maintain the original tone and meaning.
Only fix errors, don't rewrite for style.]],
				},

				{
					name = "wording",
					description = "Enhance clarity and professionalism",
					prompt = [[Improve the wording for clarity and professionalism:

Enhance:
- Clarity and conciseness
- Professional tone
- Sentence structure
- Word choice
- Flow and readability

Maintain the core message while making it more polished.]],
				},

				{
					name = "concise",
					description = "Reduce length while preserving meaning",
					prompt = [[Make this text more concise without losing important information:

Goals:
- Reduce word count by 30-50%
- Maintain all key information
- Improve clarity
- Remove redundancy
- Use active voice

Provide the condensed version that's punchy and clear.]],
				},

				-- UML Diagrams
				{
					name = "class",
					description = "Generate UML class diagram",
					prompt = [[Generate a detailed PlantUML class diagram:

Include:
- All classes with attributes and methods
- Visibility modifiers (+public, -private, #protected)
- Relationships (inheritance, composition, aggregation, association)
- Interfaces and abstract classes
- Multiplicity on associations
- Stereotypes where appropriate

Format as complete PlantUML code ready to render.]],
				},

				{
					name = "sequence",
					description = "Generate UML sequence diagram",
					prompt = [[Generate a PlantUML sequence diagram showing the flow:

Include:
- All actors/participants
- Method calls with parameters
- Return values
- Loops and conditionals
- Asynchronous calls if present
- Error/exception flows
- Notes for complex logic

Show the complete interaction flow clearly.]],
				},

				{
					name = "usecase",
					description = "Generate UML use case diagram",
					prompt = [[Generate a PlantUML use case diagram:

Include:
- Actors (users, systems)
- Use cases with clear names
- Relationships (include, extend, generalization)
- System boundaries
- Primary and secondary actors

Focus on user interactions and system capabilities.]],
				},

				{
					name = "activity",
					description = "Generate UML activity diagram",
					prompt = [[Generate a PlantUML activity diagram for the workflow:

Include:
- Start and end points
- Activities and actions
- Decision points with conditions
- Parallel activities (fork/join)
- Swimlanes if multiple actors
- Exception handling flows

Show the complete process flow clearly.]],
				},

				-- Algorithm Analysis
				{
					name = "analyze",
					description = "Analyze algorithm complexity and efficiency",
					prompt = [[Analyze this algorithm/data structure implementation:

Provide:
1. **Time Complexity**:
   - Best case: O(?)
   - Average case: O(?)
   - Worst case: O(?)
   - Explanation of each case
2. **Space Complexity**:
   - Auxiliary space: O(?)
   - Total space: O(?)
3. **Optimization Opportunities**:
   - Better algorithms
   - Better data structures
   - Implementation improvements
4. **Comparison**:
   - Alternative approaches
   - Trade-offs analysis
5. **Code**: Optimized implementation

Focus on practical improvements and real-world performance.]],
				},
			},

			-- =================================================================
			-- Slash Commands
			-- =================================================================
			slash_commands = {
				{
					name = "help",
					description = "Show available commands and shortcuts",
				},
				{
					name = "clear",
					description = "Clear the current chat history",
				},
				{
					name = "model",
					description = "Switch AI model",
				},
				{
					name = "stop",
					description = "Stop current generation",
				},
			},

			-- =================================================================
			-- Highlights
			-- =================================================================
			highlights = {
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
			},

			-- =================================================================
			-- Diff Settings
			-- =================================================================
			diff = {
				autojump = true,
				list_opener = "copen",
				override_timeoutlen = 500,
			},
		},

		config = function(_, opts)
			-- Get Anthropic API key from environment variable
			local api_key = os.getenv("ANTHROPIC_API_KEY")
			if not api_key then
				vim.notify("Warning: ANTHROPIC_API_KEY environment variable not set", vim.log.levels.WARN)
				return
			end

			-- Setup avante with options
			require("avante").setup(opts)

			-- =================================================================
			-- Avante Command Palette
			-- =================================================================

			-- Function to show all available Avante commands
			local function show_avante_commands()
				-- Define all available commands with their descriptions and actions
				local commands = {
					-- Main Chat Commands
					{
						name = "Ask",
						desc = "Start a new chat with Avante",
						key = "<leader>aa",
						action = function()
							require("avante.api").ask()
						end,
						mode = "n,v",
					},
					{
						name = "Edit",
						desc = "Edit selected code with Avante",
						key = "<leader>ae",
						action = function()
							require("avante.api").edit()
						end,
						mode = "n,v",
					},
					{
						name = "Refresh",
						desc = "Refresh Avante response",
						key = "<leader>ar",
						action = function()
							require("avante.api").refresh()
						end,
						mode = "v",
					},
					{
						name = "Toggle Sidebar",
						desc = "Toggle Avante sidebar",
						key = "<leader>cc",
						action = function()
							require("avante.api").toggle()
						end,
						mode = "n,v",
					},
					{
						name = "Focus",
						desc = "Focus on Avante window",
						key = "<leader>af",
						action = function()
							require("avante.api").focus()
						end,
						mode = "n,v",
					},

					-- Chat Management
					{
						name = "Chat History",
						desc = "Show chat history",
						key = "<leader>ah",
						action = function()
							vim.cmd("AvanteHistory")
						end,
						mode = "n",
					},
					{
						name = "Clear Chat",
						desc = "Clear current chat",
						key = "<leader>al",
						action = function()
							vim.cmd("AvanteClear")
						end,
						mode = "n",
					},
					{
						name = "Stop Generation",
						desc = "Stop current AI generation",
						key = "<leader>ax",
						action = function()
							vim.cmd("AvanteStop")
						end,
						mode = "n",
					},

					-- Model Management
					{
						name = "Switch Model",
						desc = "Switch AI model",
						key = "<leader>am",
						action = function()
							vim.cmd("AvanteModel")
						end,
						mode = "n",
					},
					{
						name = "Switch Provider",
						desc = "Switch AI provider",
						key = "<leader>ap",
						action = function()
							vim.cmd("AvanteProvider")
						end,
						mode = "n",
					},
					{
						name = "Zen Mode",
						desc = "Enter zen mode",
						key = "<leader>az",
						action = function()
							require("avante.api").zen_mode()
						end,
						mode = "n",
					},

					-- Code Analysis
					{
						name = "Explain Code",
						desc = "Explain selected code",
						key = "<leader>ce",
						action = function()
							require("avante.api").ask({
								question = "Please explain how the selected code works",
							})
						end,
						mode = "v",
					},
					{
						name = "Code Review",
						desc = "Perform code review",
						key = "<leader>cr",
						action = function()
							require("avante.api").ask({
								question = "Perform a comprehensive code review",
							})
						end,
						mode = "v",
					},
					{
						name = "Security Audit",
						desc = "Perform security audit",
						key = "<leader>cs",
						action = function()
							require("avante.api").ask({
								question = "Perform a comprehensive security audit",
							})
						end,
						mode = "v",
					},
					{
						name = "Generate Tests",
						desc = "Generate unit tests",
						key = "<leader>ct",
						action = function()
							require("avante.api").ask({
								question = "Generate comprehensive tests",
							})
						end,
						mode = "v",
					},
					{
						name = "Refactor Code",
						desc = "Refactor selected code",
						key = "<leader>cR",
						action = function()
							require("avante.api").ask({
								question = "Refactor for improved clarity and maintainability",
							})
						end,
						mode = "v",
					},
					{
						name = "Optimize Performance",
						desc = "Optimize code performance",
						key = "<leader>co",
						action = function()
							require("avante.api").ask({
								question = "Analyze and optimize performance",
							})
						end,
						mode = "v",
					},
					{
						name = "Fix Code",
						desc = "Fix code issues",
						key = "<leader>cf",
						action = function()
							require("avante.api").ask({
								question = "Analyze and fix this code",
							})
						end,
						mode = "n,v",
					},
					{
						name = "Generate Documentation",
						desc = "Generate code documentation",
						key = "<leader>cD",
						action = function()
							require("avante.api").ask({
								question = "Generate comprehensive documentation",
							})
						end,
						mode = "v",
					},

					-- Git Integration
					{
						name = "Git Code Review",
						desc = "Review git changes",
						key = "<leader>cG",
						action = function()
							vim.cmd("AvanteGitReview")
						end,
						mode = "n",
					},
					{
						name = "Generate PR Description",
						desc = "Generate pull request description",
						key = "<leader>cP",
						action = function()
							vim.cmd("AvanteGeneratePR")
						end,
						mode = "n",
					},
					{
						name = "Generate Commit Message",
						desc = "Generate commit message",
						key = "<leader>cC",
						action = function()
							vim.cmd("AvanteGenerateCommit")
						end,
						mode = "n",
					},

					-- Memory Management
					{
						name = "Reload Memory Files",
						desc = "Reload CLAUDE.md/GEMINI.md files",
						key = "<leader>amr",
						action = function()
							vim.cmd("AvanteReloadMemory")
						end,
						mode = "n",
					},
					{
						name = "Show Memory Files",
						desc = "Show loaded memory files",
						key = "<leader>ams",
						action = function()
							vim.cmd("AvanteShowMemory")
						end,
						mode = "n",
					},
					{
						name = "Clear Memory Files",
						desc = "Clear memory files from context",
						key = "<leader>amc",
						action = function()
							vim.cmd("AvanteClearMemory")
						end,
						mode = "n",
					},

					-- UML Diagrams
					{
						name = "Class Diagram",
						desc = "Generate PlantUML class diagram",
						key = "<leader>uc",
						action = function()
							require("avante.api").ask({
								question = "Generate a PlantUML class diagram",
							})
						end,
						mode = "v",
					},
					{
						name = "Sequence Diagram",
						desc = "Generate PlantUML sequence diagram",
						key = "<leader>us",
						action = function()
							require("avante.api").ask({
								question = "Generate a PlantUML sequence diagram",
							})
						end,
						mode = "v",
					},
					{
						name = "Activity Diagram",
						desc = "Generate PlantUML activity diagram",
						key = "<leader>ua",
						action = function()
							require("avante.api").ask({
								question = "Generate a PlantUML activity diagram",
							})
						end,
						mode = "v",
					},

					-- Text Processing
					{
						name = "Summarize Text",
						desc = "Create a concise summary",
						key = "<leader>ts",
						action = function()
							require("avante.api").ask({
								question = "Summarize concisely",
							})
						end,
						mode = "v",
					},
					{
						name = "Fix Grammar",
						desc = "Fix grammar and spelling",
						key = "<leader>tg",
						action = function()
							require("avante.api").ask({
								question = "Fix grammar and spelling",
							})
						end,
						mode = "v",
					},
					{
						name = "Improve Wording",
						desc = "Improve clarity and professionalism",
						key = "<leader>tw",
						action = function()
							require("avante.api").ask({
								question = "Improve wording for clarity and professionalism",
							})
						end,
						mode = "v",
					},
					{
						name = "Make Concise",
						desc = "Reduce text length while preserving meaning",
						key = "<leader>tc",
						action = function()
							require("avante.api").ask({
								question = "Make more concise",
							})
						end,
						mode = "v",
					},

					-- Algorithm Analysis
					{
						name = "Algorithm Analysis",
						desc = "Analyze algorithm complexity",
						key = "<leader>ca",
						action = function()
							require("avante.api").ask({
								question = "Analyze this algorithm",
							})
						end,
						mode = "v",
					},

					-- Type Conversion
					{
						name = "Convert to TypeScript",
						desc = "Convert JavaScript to TypeScript",
						key = "<leader>cT",
						action = function()
							require("avante.api").ask({
								question = "Convert to TypeScript with full type safety",
							})
						end,
						mode = "v",
					},

					-- Utilities
					{
						name = "Quick Chat",
						desc = "Quick chat with input prompt",
						key = "<leader>cq",
						action = function()
							vim.ui.input({ prompt = "Ask Avante: " }, function(input)
								if input and input ~= "" then
									require("avante.api").ask({ question = input })
								end
							end)
						end,
						mode = "n,v",
					},
					{
						name = "Add Buffer to Context",
						desc = "Add current buffer to Avante context",
						key = "<leader>cb",
						action = function()
							require("avante.api").add_buffer()
						end,
						mode = "n,v",
					},
				}

				-- Check if telescope is available
				local has_telescope, telescope = pcall(require, "telescope")
				if has_telescope then
					local pickers = require("telescope.pickers")
					local finders = require("telescope.finders")
					local conf = require("telescope.config").values
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")

					pickers
						.new({}, {
							prompt_title = "Avante Commands",
							finder = finders.new_table({
								results = commands,
								entry_maker = function(entry)
									return {
										value = entry,
										display = string.format("%-25s %s (%s)", entry.name, entry.desc, entry.key),
										ordinal = entry.name .. " " .. entry.desc .. " " .. entry.key,
									}
								end,
							}),
							sorter = conf.generic_sorter({}),
							attach_mappings = function(prompt_bufnr, map)
								actions.select_default:replace(function()
									actions.close(prompt_bufnr)
									local selection = action_state.get_selected_entry()
									if selection and selection.value and selection.value.action then
										selection.value.action()
									end
								end)
								return true
							end,
						})
						:find()
				else
					-- Fallback to vim.ui.select if telescope is not available
					local items = {}
					for _, cmd in ipairs(commands) do
						table.insert(items, string.format("%-25s %s (%s)", cmd.name, cmd.desc, cmd.key))
					end

					vim.ui.select(items, {
						prompt = "Select Avante Command:",
						format_item = function(item)
							return item
						end,
					}, function(choice, idx)
						if choice and idx and commands[idx] and commands[idx].action then
							commands[idx].action()
						end
					end)
				end
			end

			-- Create the command palette user command
			vim.api.nvim_create_user_command("AvanteCommandPalette", show_avante_commands, {
				desc = "Show Avante command palette",
			})

			-- =================================================================
			-- Custom Git Functions for PR/Commit generation
			-- =================================================================

			-- Helper function to run shell commands
			local function run_command(cmd)
				local handle = io.popen(cmd)
				local result = handle and handle:read("*a") or ""
				if handle then
					handle:close()
				end
				return result:gsub("%s+$", "")
			end

			-- Git Code Review Command
			vim.api.nvim_create_user_command("AvanteGitReview", function()
				-- Get git diff
				local diff = run_command("git diff 2>/dev/null")
				if diff == "" then
					diff = run_command("git diff --staged 2>/dev/null")
				end
				if diff == "" then
					vim.notify("No changes to review", vim.log.levels.WARN)
					return
				end

				-- Get recent commits
				local commits = run_command("git log --oneline -n 5 2>/dev/null")

				-- Get current branch
				local branch = run_command("git rev-parse --abbrev-ref HEAD 2>/dev/null")

				-- Get base branch
				local base_branch = run_command(
					"git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/@@'"
				)
				if base_branch == "" then
					base_branch = "origin/main"
				end

				-- Get changed files
				local files_raw = run_command("git diff --name-only 2>/dev/null")
				if files_raw == "" then
					files_raw = run_command("git diff --staged --name-only 2>/dev/null")
				end

				local file_count = 0
				for _ in string.gmatch(files_raw, "[^\r\n]+") do
					file_count = file_count + 1
				end

				-- Read full file contents
				local full_context = ""
				for file in string.gmatch(files_raw, "[^\r\n]+") do
					local f = io.open(file, "r")
					if f then
						local content = f:read("*a")
						f:close()
						local ext = file:match("%.([^%.]+)$") or "text"
						full_context = full_context
							.. string.format("\n\n## File: %s\n```%s\n%s\n```", file, ext, content)
					end
				end

				-- Build the prompt
				local prompt = string.format(
					"## Pull Request Review\n\n"
						.. "**Branch**: %s → %s\n"
						.. "**Files Changed**: %d\n\n"
						.. "### Recent Commits\n```\n%s\n```\n\n"
						.. "### Git Diff\n```diff\n%s\n```\n\n"
						.. "### Full File Context\n%s\n\n"
						.. "Please provide a thorough code review using this format:\n\n"
						.. "#### 🎯 Summary\nBrief overview of what these changes accomplish\n\n"
						.. "#### ✅ What's Good\nPositive aspects of the implementation\n\n"
						.. "#### 🚨 Critical Issues (Blocking)\nMust be fixed before merge\n\n"
						.. "#### ⚠️ Important Suggestions (Non-blocking)\nShould be addressed but not blocking\n\n"
						.. "#### 💡 Minor Improvements (Optional)\nNice-to-have enhancements\n\n"
						.. "#### 📊 Impact Assessment\n"
						.. "- **Performance Impact**: None/Low/Medium/High\n"
						.. "- **Security Concerns**: None/Present - describe\n"
						.. "- **Breaking Changes**: No/Yes - describe\n\n"
						.. "#### ✓ Verdict\n✅ Approve / 🔄 Request Changes / 💬 Needs Discussion",
					branch,
					base_branch,
					file_count,
					commits,
					diff,
					full_context
				)

				-- Open Avante with the prompt
				require("avante.api").ask({ question = prompt })
			end, { desc = "Avante: Git code review" })

			-- Generate PR Description Command
			vim.api.nvim_create_user_command("AvanteGeneratePR", function()
				-- Get current branch
				local branch = run_command("git rev-parse --abbrev-ref HEAD 2>/dev/null")

				-- Get base branch
				local base_branch = run_command(
					"git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/@@'"
				)
				if base_branch == "" then
					base_branch = "origin/main"
				end

				-- Get diff
				local diff = run_command("git diff --staged 2>/dev/null")
				if diff == "" then
					diff = run_command("git diff 2>/dev/null")
				end
				if diff == "" then
					local compare_base = branch == base_branch:gsub("^origin/", "") and "HEAD~1"
						or base_branch
					diff = run_command(string.format("git diff %s...HEAD 2>/dev/null", compare_base))
				end

				-- Get commits
				local commits = run_command(
					string.format("git log --oneline %s..HEAD 2>/dev/null | head -20", base_branch)
				)
				if commits == "" then
					commits = run_command("git log --oneline -10 2>/dev/null")
				end

				-- Get stats
				local stats =
					run_command(string.format("git diff --stat %s...HEAD 2>/dev/null", base_branch))
				if stats == "" then
					stats = run_command("git diff --stat 2>/dev/null")
				end

				-- Get changed files
				local files_raw =
					run_command(string.format("git diff --name-only %s...HEAD 2>/dev/null", base_branch))
				if files_raw == "" then
					files_raw = run_command("git diff --name-only 2>/dev/null")
				end

				local file_count = 0
				for _ in string.gmatch(files_raw, "[^\r\n]+") do
					file_count = file_count + 1
				end

				-- Build prompt
				local prompt = string.format(
					"Analyze the following changes and generate a comprehensive pull request description:\n\n"
						.. "## Git Information\n"
						.. "Branch: %s -> %s\n"
						.. "Files Changed: %d\n\n"
						.. "### Recent Commits\n```\n%s\n```\n\n"
						.. "### Change Statistics\n```\n%s\n```\n\n"
						.. "### Git Diff\n```diff\n%s\n```\n\n"
						.. "## Generate a PR description with:\n\n"
						.. "## Title\nGenerate a clear, descriptive PR title following conventional commits format\n\n"
						.. "## Type of Change\n- Bug fix / New feature / Breaking change / Documentation / Performance / Refactoring\n\n"
						.. "## Description\nDetailed description of what was changed and how it works\n\n"
						.. "## Technical Implementation Details\nKey architectural decisions and changes\n\n"
						.. "## Testing\nWhat tests were added/updated, manual testing instructions\n\n"
						.. "## Security Considerations\nAny security implications\n\n"
						.. "## Review Checklist\nCode quality, testing, documentation items",
					branch,
					base_branch,
					file_count,
					commits,
					stats,
					diff
				)

				require("avante.api").ask({ question = prompt })
			end, { desc = "Avante: Generate PR description" })

			-- Generate Commit Message Command
			vim.api.nvim_create_user_command("AvanteGenerateCommit", function()
				local diff = run_command("git diff --staged 2>/dev/null")
				if diff == "" then
					diff = run_command("git diff 2>/dev/null")
				end
				if diff == "" then
					vim.notify("No changes to commit", vim.log.levels.WARN)
					return
				end

				local prompt = string.format(
					[[Generate a conventional commit message for these changes:

```diff
%s
```

Follow the conventional commits format:
- type(scope): subject (50 chars max)
- blank line
- body (72 chars per line, explain what and why)
- blank line  
- footer (breaking changes, issues closed)

Types: feat, fix, docs, style, refactor, perf, test, chore, build, ci

Provide:
1. **Primary commit message** (ready to use)
2. **Alternative versions** (2-3 options)
3. **Explanation** of the chosen type and scope]],
					diff
				)

				require("avante.api").ask({ question = prompt })
			end, { desc = "Avante: Generate commit message" })
		end,

		-- =================================================================
		-- Keybindings
		-- =================================================================
		keys = {
			-- Main Chat Commands
			{
				"<leader>aa",
				function()
					require("avante.api").ask()
				end,
				desc = "Avante: Ask",
				mode = { "n", "v" },
			},
			{
				"<leader>ae",
				function()
					require("avante.api").edit()
				end,
				desc = "Avante: Edit",
				mode = { "n", "v" },
			},
			{
				"<leader>ar",
				function()
					require("avante.api").refresh()
				end,
				desc = "Avante: Refresh",
				mode = "v",
			},
			{
				"<leader>cc",
				function()
					require("avante.api").toggle()
				end,
				desc = "Avante: Toggle sidebar",
				mode = { "n", "v" },
			},

			-- Focus Commands
			{
				"<leader>af",
				function()
					require("avante.api").focus()
				end,
				desc = "Avante: Focus",
				mode = { "n", "v" },
			},

			-- Chat History
			{
				"<leader>ah",
				"<cmd>AvanteHistory<cr>",
				desc = "Avante: Chat history",
				mode = "n",
			},

			-- Clear Chat
			{
				"<leader>al",
				"<cmd>AvanteClear<cr>",
				desc = "Avante: Clear chat",
				mode = "n",
			},

			-- Stop Generation
			{
				"<leader>ax",
				"<cmd>AvanteStop<cr>",
				desc = "Avante: Stop generation",
				mode = "n",
			},

			-- Model Selection
			{
				"<leader>am",
				"<cmd>AvanteModel<cr>",
				desc = "Avante: Switch model",
				mode = "n",
			},

			-- Provider Selection
			{
				"<leader>ap",
				"<cmd>AvanteProvider<cr>",
				desc = "Avante: Switch provider",
				mode = "n",
			},

			-- Zen Mode (Cursor-like CLI experience)
			{
				"<leader>az",
				function()
					require("avante.api").zen_mode()
				end,
				desc = "Avante: Zen mode",
				mode = "n",
			},

			-- =================================================================
			-- Code-Specific Shortcuts (ported from CodeCompanion)
			-- =================================================================

			-- Explain Code
			{
				"<leader>ce",
				function()
					require("avante.api").ask({
						question = [[Please explain how the selected code works:

Focus on:
- The main purpose and algorithm
- Key data structures and design patterns used
- Time/space complexity if relevant
- How it handles edge cases
- Integration points with other code]],
					})
				end,
				desc = "Avante: Explain code",
				mode = "v",
			},

			-- Code Review
			{
				"<leader>cr",
				function()
					require("avante.api").ask({
						question = [[Perform a comprehensive code review:

Review checklist:
- [ ] **Correctness**: Logic errors, boundary conditions, null handling
- [ ] **Performance**: Algorithmic complexity, database queries, caching
- [ ] **Security**: Input validation, authentication, data sanitization
- [ ] **Maintainability**: Code clarity, naming, structure
- [ ] **Error Handling**: Exception handling, error messages, recovery
- [ ] **Testing**: What tests are needed, edge cases to cover

Format: Critical Issues → Important Suggestions → Minor Improvements → Positive Aspects]],
					})
				end,
				desc = "Avante: Code review",
				mode = "v",
			},

			-- Security Audit
			{
				"<leader>cs",
				function()
					require("avante.api").ask({
						question = [[Perform a comprehensive security audit:

Analyze for:
- Injection vulnerabilities (SQL, NoSQL, Command)
- Authentication & Authorization issues
- Data Exposure risks
- XSS & CSRF vulnerabilities
- Input Validation problems
- Configuration Security issues

For each issue: Severity, Description, Impact, Remediation, Prevention]],
					})
				end,
				desc = "Avante: Security audit",
				mode = "v",
			},

			-- Generate Tests
			{
				"<leader>ct",
				function()
					require("avante.api").ask({
						question = [[Generate comprehensive tests:

Requirements:
- Use appropriate testing framework
- Cover: happy path, edge cases, error scenarios
- Descriptive test names
- Proper setup/teardown
- Mock external dependencies
- Target >80% coverage

Provide complete, runnable test code.]],
					})
				end,
				desc = "Avante: Generate tests",
				mode = "v",
			},

			-- Refactor Code
			{
				"<leader>cR",
				function()
					require("avante.api").ask({
						question = [[Refactor for improved clarity and maintainability:

- Apply SOLID principles
- Improve naming
- Reduce complexity
- Extract reusable functions
- Follow language best practices
- Preserve functionality

Output: Refactored Code, Change Summary, Justification]],
					})
				end,
				desc = "Avante: Refactor code",
				mode = "v",
			},

			-- Optimize Performance
			{
				"<leader>co",
				function()
					require("avante.api").ask({
						question = [[Analyze and optimize performance:

Areas:
1. Time Complexity (current vs optimized Big-O)
2. Space Complexity
3. Database/IO optimization
4. Better algorithms/data structures
5. Parallelization opportunities
6. Caching strategies

For each: Current Issue, Solution, Performance Gain, Trade-offs]],
					})
				end,
				desc = "Avante: Optimize performance",
				mode = "v",
			},

			-- Fix Code/Error
			{
				"<leader>cf",
				function()
					require("avante.api").ask({
						question = [[Analyze and fix this code:

Provide:
1. Issue Identification
2. Root Cause Analysis
3. Fixed Code (ready to paste)
4. Explanation of changes
5. Test Cases to verify
6. Prevention Tips]],
					})
				end,
				desc = "Avante: Fix code",
				mode = { "n", "v" },
			},

			-- Generate Documentation
			{
				"<leader>cD",
				function()
					require("avante.api").ask({
						question = [[Generate comprehensive documentation:

Include:
1. Overview (purpose, use cases)
2. API Reference (signatures, params, returns, errors)
3. Usage Examples (basic, advanced, error handling)
4. Performance Notes
5. Dependencies

Use appropriate doc format (JSDoc, docstrings, etc.)]],
					})
				end,
				desc = "Avante: Generate docs",
				mode = "v",
			},

			-- =================================================================
			-- Git Integration Commands
			-- =================================================================

			-- Git Code Review
			{
				"<leader>cG",
				"<cmd>AvanteGitReview<cr>",
				desc = "Avante: Git code review",
				mode = "n",
			},

			-- Generate PR Description
			{
				"<leader>cP",
				"<cmd>AvanteGeneratePR<cr>",
				desc = "Avante: Generate PR description",
				mode = "n",
			},

			-- Generate Commit Message
			{
				"<leader>cC",
				"<cmd>AvanteGenerateCommit<cr>",
				desc = "Avante: Generate commit message",
				mode = "n",
			},

			-- =================================================================
			-- Additional Shortcuts
			-- =================================================================

			-- Quick Chat (prompt input)
			{
				"<leader>cq",
				function()
					vim.ui.input({ prompt = "Ask Avante: " }, function(input)
						if input and input ~= "" then
							require("avante.api").ask({ question = input })
						end
					end)
				end,
				desc = "Avante: Quick chat",
				mode = { "n", "v" },
			},

			-- Add Current File to Context
			{
				"<leader>cb",
				function()
					require("avante.api").add_buffer()
				end,
				desc = "Avante: Add buffer to context",
				mode = { "n", "v" },
			},

			-- =================================================================
			-- UML Diagram Shortcuts
			-- =================================================================

			-- Class Diagram
			{
				"<leader>uc",
				function()
					require("avante.api").ask({
						question = [[Generate a PlantUML class diagram:

Include:
- All classes with attributes and methods
- Visibility modifiers (+, -, #)
- Relationships (inheritance, composition, aggregation)
- Interfaces and abstract classes
- Multiplicity on associations

Format as complete PlantUML code.]],
					})
				end,
				desc = "Avante: Class diagram",
				mode = "v",
			},

			-- Sequence Diagram
			{
				"<leader>us",
				function()
					require("avante.api").ask({
						question = [[Generate a PlantUML sequence diagram:

Include:
- All actors/participants
- Method calls with parameters
- Return values
- Loops and conditionals
- Async calls
- Error flows
- Notes for complex logic]],
					})
				end,
				desc = "Avante: Sequence diagram",
				mode = "v",
			},

			-- Activity Diagram
			{
				"<leader>ua",
				function()
					require("avante.api").ask({
						question = [[Generate a PlantUML activity diagram:

Include:
- Start/end points
- Activities and actions
- Decision points
- Parallel activities (fork/join)
- Swimlanes if needed
- Exception flows]],
					})
				end,
				desc = "Avante: Activity diagram",
				mode = "v",
			},

			-- =================================================================
			-- Text Processing Shortcuts
			-- =================================================================

			-- Summarize
			{
				"<leader>ts",
				function()
					require("avante.api").ask({
						question = [[Summarize concisely:
- Key Points (bullets)
- Brief Summary (2-3 sentences)
- Action Items
- Important Details]],
					})
				end,
				desc = "Avante: Summarize text",
				mode = "v",
			},

			-- Fix Spelling/Grammar
			{
				"<leader>tg",
				function()
					require("avante.api").ask({
						question = [[Fix grammar and spelling:
- Spelling mistakes
- Grammar errors
- Punctuation
- Capitalization

Maintain original tone. Only fix errors.]],
					})
				end,
				desc = "Avante: Fix grammar",
				mode = "v",
			},

			-- Improve Wording
			{
				"<leader>tw",
				function()
					require("avante.api").ask({
						question = [[Improve wording for clarity and professionalism:
- Clarity and conciseness
- Professional tone
- Sentence structure
- Word choice
- Flow and readability]],
					})
				end,
				desc = "Avante: Improve wording",
				mode = "v",
			},

			-- Make Concise
			{
				"<leader>tc",
				function()
					require("avante.api").ask({
						question = [[Make more concise (reduce 30-50%):
- Maintain key information
- Remove redundancy
- Use active voice
- Keep it punchy and clear]],
					})
				end,
				desc = "Avante: Make concise",
				mode = "v",
			},

			-- =================================================================
			-- Algorithm Analysis
			-- =================================================================
			{
				"<leader>ca",
				function()
					require("avante.api").ask({
						question = [[Analyze this algorithm:

1. Time Complexity (best/avg/worst case)
2. Space Complexity (auxiliary/total)
3. Optimization Opportunities
4. Alternative Approaches
5. Optimized Implementation]],
					})
				end,
				desc = "Avante: Algorithm analysis",
				mode = "v",
			},

			-- =================================================================
			-- TypeScript Conversion
			-- =================================================================
			{
				"<leader>cT",
				function()
					require("avante.api").ask({
						question = [[Convert to TypeScript with full type safety:

- Add types to all variables, params, returns
- Create interfaces/types
- Use generics where beneficial
- Ensure strict mode compatibility
- Add type guards
- Convert magic values to enums]],
					})
				end,
				desc = "Avante: Convert to TypeScript",
				mode = "v",
			},

			-- =================================================================
			-- Image Paste (if in Avante input)
			-- =================================================================
			{
				"<leader>ip",
				function()
					if vim.bo.filetype == "AvanteInput" then
						require("avante.clipboard").paste_image()
					else
						require("img-clip").paste_image()
					end
				end,
				desc = "Avante/Clip: Paste image",
				mode = { "n", "v" },
			},
			-- Aceitar todas as mudanças com <leader>cy (yes/aceitar)
			{
				"<leader>cy",
				function()
					require("avante.diff").choose_all_theirs()
				end,
				desc = "Avante: Aceitar todas mudanças",
				mode = { "n" },
			},
		},
	},

	-- =================================================================
	-- Blink.cmp Integration (optional but recommended)
	-- =================================================================
	{
		"saghen/blink.cmp",
		optional = true,
		dependencies = {
			"Kaiser-Yang/blink-cmp-avante",
		},
		opts = {
			sources = {
				default = {
					"avante_commands",
					"avante_mentions",
					"avante_shortcuts",
					"avante_files",
				},
				providers = {
					avante_commands = {
						name = "avante_commands",
						module = "blink.compat.source",
						score_offset = 90,
						opts = {},
					},
					avante_files = {
						name = "avante_files",
						module = "blink.compat.source",
						score_offset = 100,
						opts = {},
					},
					avante_mentions = {
						name = "avante_mentions",
						module = "blink.compat.source",
						score_offset = 1000,
						opts = {},
					},
					avante_shortcuts = {
						name = "avante_shortcuts",
						module = "blink.compat.source",
						score_offset = 1000,
						opts = {},
					},
				},
			},
		},
	},
}
