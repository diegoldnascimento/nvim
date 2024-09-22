return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	opts = {
		api_key_cmd = nil,
		yank_register = "+",
		edit_with_instructions = {
			diff = false,
			keymaps = {
				close = "<C-c>",
				accept = "<C-y>",
				toggle_diff = "<C-d>",
				toggle_settings = "<C-o>",
				toggle_help = "<C-h>",
				cycle_windows = "<Tab>",
				use_output_as_input = "<C-i>",
			},
		},
		chat = {
			loading_text = "Loading, please wait ...",
			question_sign = "", -- 🙂
			answer_sign = "ﮧ", -- 🤖
			border_left_sign = "",
			border_right_sign = "",
			max_line_length = 120,
			sessions_window = {
				active_sign = "  ",
				inactive_sign = "  ",
				current_line_sign = "",
				border = {
					style = "rounded",
					text = {
						top = " Sessions ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			keymaps = {
				close = "<C-c>",
				yank_last = "<C-y>",
				yank_last_code = "<C-k>",
				scroll_up = "<C-u>",
				scroll_down = "<C-d>",
				new_session = "<C-n>",
				cycle_windows = "<Tab>",
				cycle_modes = "<C-f>",
				next_message = "<C-j>",
				prev_message = "<C-k>",
				select_session = "<Space>",
				rename_session = "r",
				delete_session = "d",
				draft_message = "<C-r>",
				edit_message = "e",
				delete_message = "d",
				toggle_settings = "<C-o>",
				toggle_sessions = "<C-p>",
				toggle_help = "<C-h>",
				toggle_message_role = "<C-r>",
				toggle_system_role_open = "<C-s>",
				stop_generating = "<C-x>",
			},
		},
		popup_input = {
			prompt = "  ",
			border = {
				highlight = "FloatBorder",
				style = "rounded",
				text = {
					top_align = "center",
					top = " Prompt ",
				},
			},
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
			submit = "<C-Enter>",
			submit_n = "<Enter>",
			max_visible_lines = 20,
		},
		openai_params = {
      model = "gpt-3.5-turbo",
			frequency_penalty = 0,
			presence_penalty = 0,
			max_tokens = 300,
			temperature = 0,
			top_p = 1,
			n = 1,
		},
		openai_edit_params = {
      model = "gpt-3.5-turbo",
			frequency_penalty = 0,
			presence_penalty = 0,
			temperature = 0,
			top_p = 1,
			n = 1,
		},
		use_openai_functions_for_edits = false,
		actions_paths = {},
		show_quickfixes_cmd = "Trouble quickfix",
	},
	config = function(_, opts)
		require("chatgpt").setup(opts)
	end,
	keys = {
		{ "<leader>cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT", mode = "n" },
		{
			"<leader>ce",
			"<cmd>ChatGPTEditWithInstruction<CR>",
			desc = "Edit with instruction",
			mode = { "n", "v" },
		},
		{
			"<leader>cg",
			"<cmd>ChatGPTRun grammar_correction<CR>",
			desc = "Grammar Correction",
			mode = { "n", "v" },
		},
		{ "<leader>ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
		{ "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
		{ "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
		{ "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
		{
			"<leader>co",
			"<cmd>ChatGPTRun optimize_code<CR>",
			desc = "Optimize Code",
			mode = { "n", "v" },
		},
		{ "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
		{ "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
		{
			"<leader>cx",
			"<cmd>ChatGPTRun explain_code<CR>",
			desc = "Explain Code",
			mode = { "n", "v" },
		},
		{
			"<leader>cr",
			"<cmd>ChatGPTRun roxygen_edit<CR>",
			desc = "Roxygen Edit",
			mode = { "n", "v" },
		},
		{
			"<leader>cl",
			"<cmd>ChatGPTRun code_readability_analysis<CR>",
			desc = "Code Readability Analysis",
			mode = { "n", "v" },
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
}