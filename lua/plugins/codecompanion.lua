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
									default = "claude-sonnet-4-5-20250929",
								},
							},
						})
					end,
				},
				memory = {
					claude = {
						description = "Memory files for Claude Code users",
						files = {
							"~/.claude/CLAUDE.md",
							"CLAUDE.md",
							"CLAUDE.local.md",
						},
					},
				},
				prompt_library = {
					-- Code Analysis & Explanation
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
								role = "system",
								content = "You are an expert {{filetype}} developer. Provide clear, educational explanations suitable for code reviews and documentation.",
							},
							{
								role = "user",
								content = [[
File: {{filename}}
Language: {{filetype}}
Project context: {{buf_path}}

Please explain how the following code works:

```{{filetype}}
{{selection}}
```

Focus on:
- The main purpose and algorithm
- Key data structures and design patterns used
- Time/space complexity if relevant
- How it handles edge cases
- Integration points with other code

Provide a clear explanation that would help a mid-level developer understand the implementation.]],
							},
						},
					},

					-- Code Quality & Review
					["Code Review"] = {
						strategy = "chat",
						description = "Perform a detailed code review",
						opts = {
							mapping = "<leader>cr",
							modes = { "v" },
							slash_cmd = "review",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a senior software engineer with expertise in {{filetype}} and modern best practices. Provide actionable, specific feedback that improves code quality, maintainability, and performance.",
							},
							{
								role = "user",
								content = [[
Please perform a comprehensive code review:

```{{filetype}}
{{selection}}
```

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
						},
					},

					["Security Audit"] = {
						strategy = "chat",
						description = "Perform security analysis",
						opts = {
							mapping = "<leader>cs",
							modes = { "v" },
							slash_cmd = "security",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a security expert specializing in application security and OWASP guidelines.",
							},
							{
								role = "user",
								content = [[
Perform a comprehensive security audit:

```{{filetype}}
{{selection}}
```

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
						},
					},

					-- Testing
					["Generate Tests"] = {
						strategy = "chat",
						description = "Generate comprehensive unit tests",
						opts = {
							mapping = "<leader>ct",
							modes = { "v" },
							slash_cmd = "tests",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a test automation expert. Generate comprehensive, maintainable tests following TDD best practices.",
							},
							{
								role = "user",
								content = [[
Generate comprehensive tests for:

```{{filetype}}
{{selection}}
```

Requirements:
1. **Framework**: Use the appropriate testing framework for {{filetype}}
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
						},
					},

					-- Refactoring & Optimization
					["Refactor Code"] = {
						strategy = "chat",
						description = "Refactor code for clarity and maintainability",
						opts = {
							mapping = "<leader>cR",
							modes = { "v" },
							slash_cmd = "refactor",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a software architect focused on clean code, SOLID principles, and maintainability.",
							},
							{
								role = "user",
								content = [[
Refactor this code for improved clarity and maintainability:

```{{filetype}}
{{selection}}
```

Requirements:
- Apply SOLID principles and design patterns where appropriate
- Improve naming for clarity and expressiveness
- Reduce complexity and improve readability
- Extract methods/functions for reusability
- Follow {{filetype}} idioms and best practices
- Preserve all existing functionality
- Add explanatory comments for complex logic

Output format:
1. **Refactored Code** (ready to paste)
2. **Change Summary** (what was changed)
3. **Justification** (why each change improves the code)
4. **Metrics** (complexity reduction, lines saved, etc.)

Ensure the refactored code is production-ready and well-structured.]],
							},
						},
					},

					["Performance Optimization"] = {
						strategy = "chat",
						description = "Optimize code performance",
						opts = {
							mapping = "<leader>co",
							modes = { "v" },
							slash_cmd = "optimize",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a performance engineer specializing in optimization and scalability.",
							},
							{
								role = "user",
								content = [[
Analyze and optimize the performance of:

```{{filetype}}
{{selection}}
```

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
						},
					},

					-- Error Handling & Debugging
					["Fix Code"] = {
						strategy = "chat",
						description = "Fix code to work as intended",
						opts = {
							slash_cmd = "fix",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a debugging expert. Identify root causes and provide robust fixes.",
							},
							{
								role = "user",
								content = [[
Please analyze and fix the following code:

```{{filetype}}
{{selection}}
```

Diagnostics: {{diagnostics}}

Provide:
1. **Issue Identification**: What's wrong with the current code
2. **Root Cause Analysis**: Why the issue occurs
3. **Fixed Code**: Complete corrected version (ready to paste)
4. **Explanation**: Detailed explanation of changes
5. **Test Cases**: How to verify the fix works
6. **Prevention Tips**: How to avoid this issue in the future

Ensure the fix is robust and handles edge cases properly.]],
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
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a debugging specialist. Provide clear explanations and reliable solutions.",
							},
							{
								role = "user",
								content = [[
Analyze and fix this error:

```{{filetype}}
{{selection}}
```

Diagnostics/Error: {{diagnostics}}

Please provide:
1. **Error Explanation**: What the error means in simple terms
2. **Root Cause**: Why this error is occurring
3. **Solution**: Fixed code with the error resolved
4. **Alternative Approaches**: Other ways to solve this
5. **Related Issues**: Common related problems to watch for
6. **Best Practices**: How to prevent similar errors

Make sure the solution is production-ready and well-tested.]],
							},
						},
					},

					-- Code Quality Improvements
					["Better Naming"] = {
						strategy = "chat",
						description = "Suggest better variable and function names",
						opts = {
							slash_cmd = "naming",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Improve naming in this code for better readability:

```{{filetype}}
{{selection}}
```

Guidelines:
- Use descriptive, self-documenting names
- Follow {{filetype}} naming conventions
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
						},
					},

					-- Documentation
					["Generate Documentation"] = {
						strategy = "chat",
						description = "Generate comprehensive documentation",
						opts = {
							mapping = "<leader>cD",
							modes = { "v" },
							slash_cmd = "docs",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a technical writer specializing in API documentation and developer guides.",
							},
							{
								role = "user",
								content = [[
Generate comprehensive documentation for:

```{{filetype}}
{{selection}}
```

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

Use the appropriate format for {{filetype}}:
- JavaScript/TypeScript: JSDoc with full type annotations
- Python: Google-style docstrings
- Java: Complete Javadoc
- Go: godoc format
- C#: XML documentation comments

Ensure documentation is complete, accurate, and helpful for developers.]],
							},
						},
					},

					["Swagger API Docs"] = {
						strategy = "chat",
						description = "Generate Swagger/OpenAPI documentation",
						opts = {
							slash_cmd = "swagger",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are an API documentation expert specializing in OpenAPI/Swagger specifications.",
							},
							{
								role = "user",
								content = [[
Generate complete Swagger/OpenAPI documentation:

```{{filetype}}
{{selection}}
```

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
						},
					},

					["JSDoc Documentation"] = {
						strategy = "chat",
						description = "Generate complete JSDoc documentation",
						opts = {
							slash_cmd = "jsdoc",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Generate comprehensive JSDoc documentation:

```{{filetype}}
{{selection}}
```

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
						},
					},

					-- Type Conversion
					["Convert to TypeScript"] = {
						strategy = "chat",
						description = "Convert JavaScript to TypeScript with full types",
						opts = {
							slash_cmd = "typescript",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are a TypeScript expert. Convert code with comprehensive, strict typing.",
							},
							{
								role = "user",
								content = [[
Convert to TypeScript with comprehensive type safety:

```javascript
{{selection}}
```

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
						},
					},

					-- Text Processing
					["Summarize Text"] = {
						strategy = "chat",
						description = "Create a concise summary",
						opts = {
							slash_cmd = "summarize",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Summarize the following text concisely:

{{selection}}

Provide:
1. **Key Points**: Main ideas in bullet form
2. **Brief Summary**: 2-3 sentence overview
3. **Action Items**: If any are mentioned
4. **Important Details**: Critical information to remember

Keep the summary clear, accurate, and actionable.]],
							},
						},
					},

					["Fix Spelling"] = {
						strategy = "chat",
						description = "Correct grammar and spelling errors",
						opts = {
							slash_cmd = "spelling",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Correct grammar and spelling errors:

{{selection}}

Fix all:
- Spelling mistakes
- Grammar errors
- Punctuation issues
- Capitalization errors

Maintain the original tone and meaning.
Only fix errors, don't rewrite for style.]],
							},
						},
					},

					["Improve Wording"] = {
						strategy = "chat",
						description = "Enhance clarity and professionalism",
						opts = {
							slash_cmd = "wording",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Improve the wording for clarity and professionalism:

{{selection}}

Enhance:
- Clarity and conciseness
- Professional tone
- Sentence structure
- Word choice
- Flow and readability

Maintain the core message while making it more polished.]],
							},
						},
					},

					["Make Concise"] = {
						strategy = "chat",
						description = "Reduce length while preserving meaning",
						opts = {
							slash_cmd = "concise",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Make this text more concise without losing important information:

{{selection}}

Goals:
- Reduce word count by 30-50%
- Maintain all key information
- Improve clarity
- Remove redundancy
- Use active voice

Provide the condensed version that's punchy and clear.]],
							},
						},
					},

					-- UML Diagrams
					["PlantUML Class Diagram"] = {
						strategy = "chat",
						description = "Generate UML class diagram",
						opts = {
							slash_cmd = "class",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Generate a detailed PlantUML class diagram:

```{{filetype}}
{{selection}}
```

Include:
- All classes with attributes and methods
- Visibility modifiers (+public, -private, #protected)
- Relationships (inheritance, composition, aggregation, association)
- Interfaces and abstract classes
- Multiplicity on associations
- Stereotypes where appropriate

Format as complete PlantUML code ready to render.]],
							},
						},
					},

					["PlantUML Sequence Diagram"] = {
						strategy = "chat",
						description = "Generate UML sequence diagram",
						opts = {
							slash_cmd = "sequence",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Generate a PlantUML sequence diagram showing the flow:

```{{filetype}}
{{selection}}
```

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
						},
					},

					["PlantUML Use Case Diagram"] = {
						strategy = "chat",
						description = "Generate UML use case diagram",
						opts = {
							slash_cmd = "usecase",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Generate a PlantUML use case diagram:

```{{filetype}}
{{selection}}
```

Include:
- Actors (users, systems)
- Use cases with clear names
- Relationships (include, extend, generalization)
- System boundaries
- Primary and secondary actors

Focus on user interactions and system capabilities.]],
							},
						},
					},

					["PlantUML Activity Diagram"] = {
						strategy = "chat",
						description = "Generate UML activity diagram",
						opts = {
							slash_cmd = "activity",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "user",
								content = [[
Generate a PlantUML activity diagram for the workflow:

```{{filetype}}
{{selection}}
```

Include:
- Start and end points
- Activities and actions
- Decision points with conditions
- Parallel activities (fork/join)
- Swimlanes if multiple actors
- Exception handling flows

Show the complete process flow clearly.]],
							},
						},
					},

					-- Algorithm Analysis
					["Algorithm Analysis"] = {
						strategy = "chat",
						description = "Analyze algorithm complexity and efficiency",
						opts = {
							slash_cmd = "analyze",
							auto_submit = true,
							stop_context_insertion = false,
						},
						prompts = {
							{
								role = "system",
								content = "You are an algorithms expert specializing in complexity analysis and optimization.",
							},
							{
								role = "user",
								content = [[
Analyze this algorithm/data structure implementation:

```{{filetype}}
{{selection}}
```

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
5. **Code**: Optimized implementation in {{filetype}}

Focus on practical improvements and real-world performance.]],
							},
						},
					},

					-- Git Integration
					["Git Code Review"] = {
						strategy = "chat",
						description = "Review git changes with detailed feedback",
						opts = {
							mapping = "<leader>cG",
							slash_cmd = "gitreview",
							auto_submit = true,
							stop_context_insertion = true,
						},
						prompts = {
							{
								role = "system",
								content = "You are a senior engineer performing a pull request review. Focus on code quality, security, performance, and maintainability. Be constructive but thorough.",
							},
							{
								role = "user",
								content = function()
									-- Get git diff
									local diff_handle = io.popen("git diff")
									local diff = diff_handle and diff_handle:read("*a") or "Error retrieving git diff"
									if diff_handle then
										diff_handle:close()
									end

									-- Get last 5 commits for better context
									local commits_handle = io.popen("git log --oneline -n 5")
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
												.. "\n```\n"
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
## Pull Request Review

**Branch**: %s → %s
**Files Changed**: %d

### Recent Commits
```
%s
```

### Git Diff
```diff
%s
```

### Full File Context
%s

Please provide a thorough code review using this format:

#### 🎯 Summary
Brief overview of what these changes accomplish

#### ✅ What's Good
Positive aspects of the implementation

#### 🚨 Critical Issues (Blocking)
Must be fixed before merge:
- Issue description
- File:Line reference
- Suggested fix with code example

#### ⚠️ Important Suggestions (Non-blocking)
Should be addressed but not blocking:
- Suggestion description
- File:Line reference
- Recommended improvement

#### 💡 Minor Improvements (Optional)
Nice-to-have enhancements

#### 🔍 Questions for Author
Clarifications needed

#### 📊 Impact Assessment
- **Performance Impact**: [None/Low/Medium/High]
- **Security Concerns**: [None/Present - describe]
- **Breaking Changes**: [No/Yes - describe]
- **Test Coverage**: [Adequate/Needs improvement - specify]
- **Documentation**: [Complete/Needs updates - specify]

#### ✓ Verdict
[✅ Approve / 🔄 Request Changes / 💬 Needs Discussion]

Focus on:
- Bugs and logic errors
- Security vulnerabilities
- Performance issues
- Code maintainability
- Test coverage
- Error handling
- Edge cases]],
										branch,
										base_branch,
										#file_paths,
										commits,
										diff,
										full_context
									)
								end,
							},
						},
					},

					["Generate Merge Request"] = {
						strategy = "chat",
						description = "Generate comprehensive PR description",
						opts = {
							mapping = "<leader>cP",
							slash_cmd = "pullrequest",
							auto_submit = true,
						},
						prompts = {
							{
								role = "system",
								content = [[You are creating a professional pull request description. Follow the EXACT template structure provided. Fill in each section based on the git changes and file contents. Do not skip sections - if a section doesn't apply, write "N/A" or "None applicable" but keep the section header.]],
							},
							{
								role = "user",
								content = function()
									-- Get current branch
									local branch_handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
									local current_branch = branch_handle and branch_handle:read("*a"):gsub("%s+$", "")
										or "unknown"
									if branch_handle then
										branch_handle:close()
									end

									-- Get base branch
									local base_branch_handle = io.popen(
										"git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/@@'"
									)
									local base_branch = base_branch_handle
											and base_branch_handle:read("*a"):gsub("%s+$", "")
										or "origin/main"
									if base_branch_handle then
										base_branch_handle:close()
									end

									-- Determine what to compare against
									local compare_base = base_branch
									if current_branch == base_branch:gsub("^origin/", "") then
										-- If on main branch, compare with HEAD~1
										compare_base = "HEAD~1"
									end

									-- Get staged diff first, fall back to unstaged if empty
									local diff_handle = io.popen("git diff --staged 2>/dev/null")
									local staged_diff = diff_handle and diff_handle:read("*a") or ""
									if diff_handle then
										diff_handle:close()
									end

									local diff = staged_diff
									if diff == "" then
										-- Try unstaged changes
										diff_handle = io.popen("git diff 2>/dev/null")
										local unstaged_diff = diff_handle and diff_handle:read("*a") or ""
										if diff_handle then
											diff_handle:close()
										end

										if unstaged_diff ~= "" then
											diff = unstaged_diff
										else
											-- If no local changes, get diff against base branch
											diff_handle = io.popen(
												string.format(
													"git diff %s...HEAD 2>/dev/null",
													vim.fn.shellescape(compare_base)
												)
											)
											diff = diff_handle and diff_handle:read("*a") or "No changes detected"
											if diff_handle then
												diff_handle:close()
											end
										end
									end

									-- Get commit messages (last 20 for more context)
									local commits_handle = io.popen(
										string.format(
											"git log --oneline %s..HEAD 2>/dev/null | head -20",
											vim.fn.shellescape(compare_base)
										)
									)
									local commits = commits_handle and commits_handle:read("*a") or ""
									if commits_handle then
										commits_handle:close()
									end

									if commits == "" then
										commits_handle = io.popen("git log --oneline -10 2>/dev/null")
										commits = commits_handle and commits_handle:read("*a") or "No commits found"
										if commits_handle then
											commits_handle:close()
										end
									end

									-- Get detailed statistics
									local stats_handle = io.popen(
										string.format(
											"git diff --stat %s...HEAD 2>/dev/null",
											vim.fn.shellescape(compare_base)
										)
									)
									local stats = stats_handle and stats_handle:read("*a") or ""
									if stats_handle then
										stats_handle:close()
									end

									if stats == "" then
										stats_handle = io.popen("git diff --stat 2>/dev/null")
										stats = stats_handle and stats_handle:read("*a") or "No statistics available"
										if stats_handle then
											stats_handle:close()
										end
									end

									-- Get list of changed files
									local files_handle = io.popen(
										string.format(
											"git diff --name-only %s...HEAD 2>/dev/null",
											vim.fn.shellescape(compare_base)
										)
									)
									local files_raw = files_handle and files_handle:read("*a") or ""
									if files_handle then
										files_handle:close()
									end

									if files_raw == "" then
										files_handle = io.popen("git diff --name-only 2>/dev/null")
										files_raw = files_handle and files_handle:read("*a") or ""
										if files_handle then
											files_handle:close()
										end
									end

									local changed_files = {}
									for file in string.gmatch(files_raw, "[^\r\n]+") do
										table.insert(changed_files, file)
									end

									-- Read full contents of changed files (limit to reasonable size)
									local full_file_contents = ""
									local max_file_size = 50000 -- Limit file size to avoid huge contexts
									local files_read = 0
									local max_files = 20 -- Limit number of files to read

									for _, filepath in ipairs(changed_files) do
										if files_read >= max_files then
											full_file_contents = full_file_contents
												.. "\n\n[Additional files omitted for brevity]"
											break
										end

										local file_handle = io.open(filepath, "r")
										if file_handle then
											-- Check file size
											local file_size = file_handle:seek("end")
											file_handle:seek("set", 0)

											if file_size and file_size <= max_file_size then
												local content = file_handle:read("*a")
												file_handle:close()

												-- Determine file type for syntax highlighting
												local extension = filepath:match("%.([^%.]+)$") or "text"

												full_file_contents = full_file_contents
													.. string.format(
														"\n\n### File: %s\n```%s\n%s\n```",
														filepath,
														extension,
														content
													)
												files_read = files_read + 1
											else
												file_handle:close()
												full_file_contents = full_file_contents
													.. string.format(
														"\n\n### File: %s\n[File too large - %d bytes, showing diff only]",
														filepath,
														file_size or 0
													)
											end
										else
											-- Try to get the file from git if it's deleted or new
											local git_file_handle = io.popen(
												string.format("git show HEAD:%s 2>/dev/null", vim.fn.shellescape(filepath))
											)
											local git_content = git_file_handle and git_file_handle:read("*a") or ""
											if git_file_handle then
												git_file_handle:close()
											end

											if git_content ~= "" then
												local extension = filepath:match("%.([^%.]+)$") or "text"
												full_file_contents = full_file_contents
													.. string.format(
														"\n\n### File: %s (from git)\n```%s\n%s\n```",
														filepath,
														extension,
														git_content
													)
												files_read = files_read + 1
											else
												full_file_contents = full_file_contents
													.. string.format(
														"\n\n### File: %s\n[Could not read file - may be deleted or new]",
														filepath
													)
											end
										end
									end

									-- Get branch comparison info
									local branch_info = string.format("Branch: %s -> %s", current_branch, base_branch)

									return string.format(
										[[Analyze the following changes and generate a comprehensive pull request description using the EXACT template structure provided below.

## Git Information

%s
Files Changed: %d

### Recent Commits
```
%s
```

### Change Statistics
```
%s
```

### Git Diff
```diff
%s
```

### Full File Contents
%s

## REQUIRED TEMPLATE - FILL IN ALL SECTIONS:

## Title
[Generate a clear, descriptive PR title following conventional commits format: type(scope): description]

## Type of Change
- [ ] Bug fix (non-breaking change fixing an issue)
- [ ] New feature (non-breaking change adding functionality)
- [ ] Breaking change (fix or feature causing existing functionality to change)
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Code refactoring
- [ ] Build/CI changes
- [ ] Test additions or modifications

## Context and Motivation
[Explain why this change is necessary. What problem does it solve? What feature does it add? Link to related issues using #issue-number format if applicable]

## Description
[Provide a detailed description of what was changed and how it works. Include the approach taken and why this solution was chosen over alternatives]

## Technical Implementation Details

### Architecture and Design Decisions:
[Explain key architectural decisions, design patterns used, and why they were chosen]

### Key Changes:
- [List each major change with a brief explanation of what it does]
- [Include file paths where significant changes occurred]
- [Explain any complex logic or algorithms introduced]

### Code Structure Modifications:
[Describe any structural changes, new modules, refactored components, or reorganization of existing code]

### Dependencies:
[List any new dependencies added or removed, with justification]

## Testing

### Test Strategy:
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] End-to-end tests added/updated
- [ ] Manual testing completed
- [ ] Performance testing completed (if applicable)
- [ ] Security testing completed (if applicable)

### Test Coverage:
[Specify current coverage percentage and delta. List what new tests were added and what scenarios they cover]

### Manual Testing Instructions:
1. [Provide step-by-step instructions for QA/reviewers to test the changes]
2. [Include test data or configuration needed]
3. [Specify expected results for each test step]
4. [Note any edge cases that were tested]

## Screenshots and Examples
[For UI changes: Include before/after screenshots or recordings]
[For API changes: Include request/response examples]
[For performance improvements: Include benchmark results]

## Security Considerations

### Security Review:
[List any security implications, vulnerabilities addressed, or new attack surfaces introduced]

### Data Privacy:
[Note any changes to data handling, storage, or transmission]

### Authentication/Authorization:
[Describe any changes to auth mechanisms or permissions]

## Documentation Updates

- [ ] Code comments and inline documentation added/updated
- [ ] README updated with new features or changes
- [ ] API documentation updated (OpenAPI/Swagger specs if applicable)
- [ ] Architecture documentation updated
- [ ] Configuration documentation updated
- [ ] Changelog/Release notes updated

## Review Checklist

### Code Quality:
- [ ] Code follows project style guide and conventions
- [ ] Self-review completed - checked own code for issues
- [ ] No commented-out code or debug statements left
- [ ] Error handling is comprehensive and appropriate
- [ ] Code is DRY (Don't Repeat Yourself) and follows SOLID principles

### Testing:
- [ ] All new and existing tests pass
- [ ] Edge cases are tested
- [ ] Error scenarios are tested
- [ ] Test coverage meets project standards

### Documentation:
- [ ] All public methods/functions have appropriate documentation
- [ ] Complex logic has explanatory comments
- [ ] README and other docs updated as needed

### Security and Performance:
- [ ] No sensitive data exposed in logs or responses
- [ ] Input validation is comprehensive
- [ ] No obvious performance bottlenecks introduced
- [ ] Resource cleanup is handled properly

## Additional Notes
[Any additional context, caveats, future work, or things reviewers should pay special attention to]],
										branch_info,
										#changed_files,
										commits,
										stats,
										diff,
										full_file_contents
									)
								end,
							},
						},
					},

					-- Commit Message Generator
					["Generate Commit Message"] = {
						strategy = "chat",
						description = "Generate conventional commit message",
						opts = {
							mapping = "<leader>cC",
							slash_cmd = "commit",
							stop_context_insertion = false,
							auto_submit = true,
						},
						prompts = {
							{
								role = "system",
								content = "You are an expert at writing clear, conventional commit messages that follow best practices.",
							},
							{
								role = "user",
								content = function()
									local diff_handle = io.popen("git diff --staged")
									local diff = diff_handle and diff_handle:read("*a") or ""
									if diff_handle then
										diff_handle:close()
									end

									if diff == "" then
										diff_handle = io.popen("git diff")
										diff = diff_handle and diff_handle:read("*a") or "No changes detected"
										if diff_handle then
											diff_handle:close()
										end
									end

									return string.format(
										[[
Generate a conventional commit message for these changes:

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
3. **Explanation** of the chosen type and scope

Make it clear, specific, and informative.]],
										diff
									)
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
							height = 0.5,
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
					auto_submit_exit_on_leave = false, -- Auto submit when leaving chat buffer
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
				"<leader>cs",
				"<cmd>CodeCompanion /security<cr>",
				desc = "CodeCompanion - Security audit",
				mode = { "v" },
			},
			{
				"<leader>co",
				"<cmd>CodeCompanion /optimize<cr>",
				desc = "CodeCompanion - Optimize performance",
				mode = { "v" },
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
			{
				"<leader>cC",
				"<cmd>CodeCompanion /commit<cr>",
				desc = "CodeCompanion - Generate commit message",
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
			-- Additional useful keybindings
			{
				"<leader>cx",
				"<cmd>CodeCompanion /explain<cr>",
				desc = "CodeCompanion - Explain (alias)",
				mode = { "v" },
			},
			{
				"<leader>ci",
				"<cmd>CodeCompanion /implement<cr>",
				desc = "CodeCompanion - Implement feature",
				mode = { "n", "v" },
			},
		},
	},
}
