return {
	{
		"jose-elias-alvarez/typescript.nvim",
		opts = {},
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.ts*",
				callback = function()
					pcall(vim.api.nvim_command, "TypescriptAddMissingImports!")
					pcall(vim.api.nvim_command, "TypescriptOrganizeImports!")
					pcall(vim.api.nvim_command, "write")
				end,
			})
		end,
	},
}
