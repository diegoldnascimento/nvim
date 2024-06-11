return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		init = function()
			-- Remove unused import on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.ts*",
				command = ":TSToolsRemoveUnusedImports",
			})

			-- Add missing imports on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.ts*",
				command = ":TSToolsAddMissingImports",
			})

			-- Sort imports on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.ts*",
				command = ":TSToolsOrganizeImports",
			})

			require("typescript-tools").setup({
				settings = {
					tsserver_plugins = {
						"@styled/typescript-styled-plugin",
					},
				},
			})
		end,
	},
}
