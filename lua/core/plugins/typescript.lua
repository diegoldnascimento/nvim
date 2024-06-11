return {
	{
		"jose-elias-alvarez/typescript.nvim",
		opts = {},
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.ts*",
				callback = function()
					vim.cmd([[TypescriptAddMissingImports!]])
					vim.cmd([[TypescriptOrganizeImports!]])
					vim.cmd("write")
				end,
			})
		end,
	},
}
