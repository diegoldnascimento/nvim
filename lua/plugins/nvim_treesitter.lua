return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "VeryLazy" },
		opts = {
			ensure_installed = {
				"bash",
				"comment",
				"css",
				"dockerfile",
				"fish",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"graphql",
				"html",
				"http",
				"javascript",
				"json",
				"json5",
				"jsonc",
				"just",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"nix",
				"php",
				"prisma",
				"proto",
				"python",
				"query",
				"regex",
				"rust",
				"scss",
				"svelte",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"vimdoc",
				"vue",
				"yaml",
				"zig",
			},
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			auto_install = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		keys = {
			{
				mode = { "n", "v" },
				"[c",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				desc = "Jump to context",
			},
		},

		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		opts = {
			filetypes = {
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
				"tsx",
				"jsx",
				"rescript",
				"xml",
				"php",
				"markdown",
				"glimmer",
				"handlebars",
				"hbs",
			},
		},
		config = function(_, opts)
			require("nvim-ts-autotag").setup(opts)
		end,
	},
}
