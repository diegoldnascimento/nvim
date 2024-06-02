return {
	"stevearc/aerial.nvim",
	event = "VeryLazy",
	opts = function()
		local opts = {
			attach_mode = "global",
			backends = { "lsp", "treesitter", "markdown", "man" },
			show_guides = true,
			layout = {
				resize_to_content = false,
				win_opts = {
					winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
					signcolumn = "yes",
					statuscolumn = " ",
				},
			},
		}
		return opts
	end,
	keys = {
		{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
	},
}
