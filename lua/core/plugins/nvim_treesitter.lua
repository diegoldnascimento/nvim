return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "VeryLazy" },
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"python",
				"vue",
				"regex",
				"sql",
				"comment",
				"toml",
				"jsonc",
				"json5",
				"gomod",
				"gowork",
				"go",
				"json",
				"proto",
				"make",
				"graphql",
				"html",
				"svelte",
				"yaml",
				"markdown",
				"markdown_inline",
				"http",
				"gitignore",
				"bash",
				"fish",
				"rust",
				"scss",
				"css",
				"lua",
				"tsx",
				"prisma",
				"php",
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
