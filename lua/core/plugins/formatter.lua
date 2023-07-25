return {
	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		config = function()
			local opts = {
				lua = { require("formatter.filetypes.lua").stylua },
				typescript = { require("formatter.filetypes.typescript").prettier },
				javascript = { require("formatter.filetypes.javascript").prettier },
				javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
				css = { require("formatter.filetypes.css").prettier },
				json = { require("formatter.filetypes.json").jq },
				go = { require("formatter.filetypes.go").gofmt },
				sh = { require("formatter.filetypes.sh").shfmt },
				terraform = { require("formatter.filetypes.terraform").terraform },

				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			}

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = opts,
			})

			-- Text Formatting
			vim.keymap.set("n", "<C-f>", function()
				if opts[vim.bo.filetype] ~= nil then
					vim.cmd([[FormatWrite]])
				else
					vim.lsp.buf.format()
				end
			end)
		end,
	},
}
