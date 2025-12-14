return {
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		init = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = require("cmp.config.compare")
			local lspkind = require("lspkind")

			require("luasnip/loaders/from_vscode").lazy_load()

			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			local opts = {
				formatting = {
					format = lspkind.cmp_format({
						menu = {
							nvim_lsp = "[LSP]",
							path = "[Path]",
							buffer = "[Buffer]",
							luasnip = "[LuaSnip]",
							emoji = "[Emoji]",
						},
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						preset = "default",
						before = function(_, vim_item)
							return vim_item
						end,
					}),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				preselect = cmp.PreselectMode.None,
				mapping = {
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-f>"] = cmp.mapping(function()
						if luasnip.jumpable(1) then
							luasnip.jump(1)
						end
					end, { "i", "s" }),
					["<C-b>"] = cmp.mapping(function()
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Insert,
					}),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				},
				sources = {
					{ name = "codecompanion" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "emoji" },
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						compare.offset,
						compare.exact,
						compare.score,
						compare.recently_used,
						compare.sort_text,
						compare.kind,
						compare.length,
						compare.order,
					},
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				experimental = {
					ghost_text = false,
					native_menu = false,
				},
			}
			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			-- Configuração específica para CodeCompanion
			cmp.setup.filetype("codecompanion", {
				sources = {
					{ name = "codecompanion" },
					{ name = "buffer" },
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			})

			cmp.setup(opts)
		end,
		dependencies = {
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
			"mlaursen/vim-react-snippets",
		},
	},
}
