return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = true,
	config = function()
		require("refactoring").setup({
			prompt_func_return_type = {
				go = true,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = true,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
			show_success_message = true, -- shows a message with information about the refactor on success
		})
	end,
	keys = {
		{
			mode = "x",
			"<leader>re",
			function()
				require("refactoring").refactor("Extract Function")
			end,
			desc = "Extract Function",
		},
		{
			mode = "x",
			"<leader>rf",
			function()
				require("refactoring").refactor("Extract Function To File")
			end,
			desc = "Extract Function To File",
		},
		{
			mode = "x",
			"<leader>rv",
			function()
				require("refactoring").refactor("Extract Variable")
			end,
			desc = "Extract Variable",
		},
		{
			mode = "n",
			"<leader>rI",
			function()
				require("refactoring").refactor("Inline Function")
			end,
			desc = "Inline Function",
		},
		{
			mode = { "n", "x" },
			"<leader>ri",
			function()
				require("refactoring").refactor("Inline Variable")
			end,
			desc = "Inline Variable",
		},
		{
			mode = "n",
			"<leader>rb",
			function()
				require("refactoring").refactor("Extract Block")
			end,
			desc = "Extract Block",
		},
		{
			mode = "n",
			"<leader>rbf",
			function()
				require("refactoring").refactor("Extract Block To File")
			end,
			desc = "Extract Block To File",
		}
	},
}
