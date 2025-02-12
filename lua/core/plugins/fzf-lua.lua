return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			{ "telescope" },
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
			previewers = {
				bat = {
					cmd = "bat",
					args = "--color=always --theme=Dracula --style=numbers,changes",
				},
			},
		},
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
				"<Leader>cd",
				function()
					require("fzf-lua").diagnostics_document({ fzf_opts = { ["--wrap"] = true } })
				end,
				desc = "Trigger code action",
			},
		},
	},
}
