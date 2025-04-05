return {
	{
		"tpope/vim-dadbod",
		cmd = {
			"DBUIToggle",
			"DBUI",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUIRenameBuffer",
			"DBUILastQueryInfo",
		},
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
	{
		"nanotee/sqls.nvim",
		cmd = {
			"SqlsExecuteQuery",
			"SqlsExecuteQueryVertical",
			"SqlsShowDatabases",
			"SqlsShowSchemas",
			"SqlsShowConnections",
			"SqlsSwitchDatabase",
			"SqlsSwitchConnection",
		},
	},
}
