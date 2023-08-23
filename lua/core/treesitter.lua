local status_ok, treesitter = pcall(require, "nvim-treesitter")

if not status_ok then
	return
end

require("nvim-treesitter.configs").setup({
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
		"solidity",
		"php",
	},
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})

local rainbow_delimiters = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	highlight = {
		"RainbowDelimiterViolet",
		"RainbowDelimiterYellow",
		"RainbowDelimiterCyan",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterRed",
	},
}
