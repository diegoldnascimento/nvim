return {
	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		config = function()
			local opts = {
				lua = { require("formatter.filetypes.lua").stylua },
				typescript = { require("formatter.filetypes.typescript").prettierd },
				javascript = { require("formatter.filetypes.javascript").prettierd },
				javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
				css = { require("formatter.filetypes.css").prettierd },
				json = { require("formatter.filetypes.json").jq },
				go = { require("formatter.filetypes.go").gofumpt },
				sh = { require("formatter.filetypes.sh").shfmt },
				terraform = { require("formatter.filetypes.terraform").terraform },
				markdown = { require("formatter.filetypes.markdown").prettierd },
				yaml = { require("formatter.filetypes.yaml").prettierd },
				php = { require("formatter.filetypes.php").php_cs_fixer },

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
