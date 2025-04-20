return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"echasnovski/mini.icons",
		},
		opts = function()
			local actions = require("fzf-lua").actions

			return {
				defaults = {
					git_icons = true,
					file_icons = true,
					color_file = true,
				},
				winopts = {
					preview = {
						wrap = true,
						default = "bat",
					},
				},
				files = {
					fd_opts = "--type f --hidden --follow --exclude .git --exclude node_modules --exclude vendor --exclude tmp --exclude dist --exclude .vscode --exclude coverage --exclude logs --exclude .npm --exclude .next",
				},
				grep = {
					grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
					rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
				},
				previewers = {
					bat = {
						cmd = "bat",
						args = "--color=always --theme=Dracula --style=numbers,changes",
					},
				},
				actions = {
					files = {
						["enter"] = actions.file_edit_or_qf,
						["ctrl-s"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
						["ctrl-t"] = actions.file_tabedit,
						["alt-q"] = actions.file_sel_to_qf,
					},
				},
				buffers = {
					keymap = { builtin = { ["<C-d>"] = false } },
					actions = { ["ctrl-x"] = false, ["ctrl-d"] = { actions.buf_del, actions.resume } },
				},

				keymap = {
					builtin = {
						true,
						["<C-d>"] = "preview-page-down",
						["<C-u>"] = "preview-page-up",
					},
					fzf = {
						true,
						["ctrl-d"] = "preview-page-down",
						["ctrl-u"] = "preview-page-up",
						["ctrl-q"] = "select-all+accept",
					},
				},
			}
		end,
		keys = {
			{
				mode = "n",
				"<Leader>fa",
				function()
					require("fzf-lua").files({ hidden = true, follow = true })
				end,
				desc = "Find all files (including hidden and ignored)",
			},

			{
				mode = "n",
				"<Leader>ff",
				function()
					require("fzf-lua").files()
				end,
				desc = "Find files",
			},
			{
				mode = "n",
				"<c-p>",
				function()
					require("fzf-lua").files()
				end,
				desc = "Find files",
			},
			{
				mode = "n",
				"<Leader>fp",
				function()
					require("fzf-lua").builtin()
				end,
				desc = "Open Builtin commands",
			},

			{
				mode = "n",
				"<Leader>fw",
				function()
					require("fzf-lua").grep_cword()
				end,
				desc = "Live grep in under cursor",
			},
			{
				mode = "n",
				"<Leader>fv",
				function()
					require("fzf-lua").grep_visual()
				end,
				desc = "Live grep in under cursor",
			},

			{
				mode = "n",
				"<Leader>fg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Live grep (fixed strings)",
			},
			{
				mode = "n",
				"<Leader>fb",
				function()
					require("fzf-lua").buffers()
				end,
				desc = "List open buffers",
			},
			{
				mode = "n",
				"<Leader>fq",
				function()
					require("fzf-lua").quickfix()
				end,
				desc = "List quickfix",
			},
			{
				mode = "n",
				"<Leader>fk",
				function()
					require("fzf-lua").keymaps()
				end,
				desc = "List keymaps",
			},

			{
				mode = "n",
				"<Leader>fr",
				function()
					require("fzf-lua").resume()
				end,
				desc = "Resume",
			},

			{
				mode = "n",
				"<Leader>fs",
				function()
					require("fzf-lua").git_status()
				end,
				desc = "Open Git Status",
			},

			{
				mode = "n",
				"<Leader>fo",
				function()
					require("fzf-lua").oldfiles()
				end,
				desc = "Find recently opened files",
			},
			{
				mode = "n",
				"<Leader>fG",
				function()
					require("fzf-lua").live_grep({ search_dirs = { vim.fn.expand("%:p:h") } })
				end,
				desc = "Live grep in current directory",
			},
			{
				mode = "n",
				"<Leader>fh",
				function()
					require("fzf-lua").help_tags()
				end,
				desc = "Search help tags",
			},
			{
				mode = "n",
				"<Leader>ca",
				function()
					require("fzf-lua").lsp_code_actions({
						winopts = { relative = "cursor", row = 1.01, col = 0, height = 0.4, width = 0.4 },
					})
				end,
				desc = "Trigger code action",
			},
			{
				mode = "n",
				"<Leader>fd",
				function()
					require("fzf-lua").diagnostics_document({ fzf_opts = { ["--wrap"] = true } })
				end,
				desc = "Show document diagnostics",
			},
			{
				"<C-k>",
				function()
					local commands = {
						{ cmd = "Conform", desc = "Format file", key = "<C-f>" },
						{
							cmd = ":lua require('conform').format({ timeout_ms = 500 })",
							desc = "Format with timeout",
							key = "<C-f>",
						},
						{
							cmd = ":lua require('neotest').run.run()",
							desc = "Run nearest test",
							key = "<leader>tr",
						},
						{
							cmd = ":lua require('neotest').run.run(vim.fn.expand('%'))",
							desc = "Run test file",
							key = "<leader>tt",
						},
						{
							cmd = ":lua require('neotest').summary.toggle()",
							desc = "Toggle test summary",
							key = "<leader>ts",
						},
						{ cmd = ":lua require('fzf-lua').files()", desc = "Find files", key = "<leader>ff" },
						{
							cmd = ":lua require('fzf-lua').git_status()",
							desc = "Git status",
							key = "<leader>fs",
						},
						{ cmd = ":lua require('fzf-lua').live_grep()", desc = "Live grep", key = "<leader>fg" },
						{
							cmd = ":lua require('fzf-lua').buffers()",
							desc = "List buffers",
							key = "<leader>fb",
						},
						{ cmd = ":lua require('lazy').home()", desc = "Open Lazy", key = "" },
						{ cmd = ":Mason", desc = "Open Mason", key = "" },
						{ cmd = ":Lazy", desc = "Open Lazy", key = "" },
						{ cmd = ":checkhealth", desc = "Check health", key = "" },
						{ cmd = ":lua require('todo-comments').jump_next()", desc = "Next todo", key = "]t" },
						{ cmd = ":LazyGit", desc = "Open LazyGit", key = "<leader>lg" },
						{ cmd = ":lua vim.lsp.buf.format()", desc = "LSP format", key = "" },
						{ cmd = ":lua vim.lsp.buf.code_action()", desc = "Code action", key = "<leader>ca" },
						{ cmd = ":lua require('spectre').open()", desc = "Open search/replace", key = "" },
						{ cmd = "MarkdownPreview", desc = "Markdown preview", key = "<leader>mp" },
						{ cmd = ":e ~/.config/nvim/", desc = "Edit Neovim config", key = "" },
						{ cmd = ":e ~/.zshrc", desc = "Edit zsh config", key = "" },
						{ cmd = ":w!", desc = "Save current file", key = "" },
					}

					-- Sort commands alphabetically by description
					table.sort(commands, function(a, b)
						return a.desc:lower() < b.desc:lower()
					end)

					local opts = {
						prompt = "Commands: ",
						winopts = {
							height = 0.6,
							width = 0.6,
							preview = { hidden = "hidden" },
						},
						actions = {
							["default"] = function(selected)
								local cmd = selected[1]
								vim.cmd(cmd.cmd)
							end,
						},
					}

					local display = {}
					local commands_lookup = {}

					for _, command in ipairs(commands) do
						local display_text = command.desc
						if command.key and command.key ~= "" then
							display_text = display_text .. " (" .. command.key .. ")"
						end
						table.insert(display, display_text)
						commands_lookup[display_text] = command
					end

					require("fzf-lua").fzf_exec(display, {
						prompt = "Commands: ",
						actions = {
							["default"] = function(selected)
								local cmd = commands_lookup[selected[1]]
								vim.cmd(cmd.cmd)
							end,
						},
					})
				end,
				desc = "Command Palette",
			},
		},
	},
}
