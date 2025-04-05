return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		keys = {
			{
				mode = "n",
				"<leader>mp",
				"<cmd>MarkdownPreviewToggle<cr>",
				{ noremap = true, silent = true },
			},
		},
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
