return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"vue",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.ts*",
				callback = function()
					pcall(vim.api.nvim_command, "TSToolsAddMissingImports")
					pcall(vim.api.nvim_command, "TSToolsRemoveUnused")
					pcall(vim.api.nvim_command, "TSToolsFixAll")
					pcall(vim.api.nvim_command, "write")
				end,
			})
		end,
	},
}
