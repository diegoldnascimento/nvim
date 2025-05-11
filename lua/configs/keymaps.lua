local opts = { noremap = true, silent = true }
-- Shorten function name

local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
--    ]],
-- 	false
-- )
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--
--

-- Remap Enter key to do nothing
keymap("n", "<CR>", "<NOP>", opts)
keymap("v", "<CR>", "<NOP>", opts)

keymap(
	"n",
	"<esc>",
	":lua for _, win in pairs(vim.api.nvim_list_wins()) do if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative == 'win' then vim.api.nvim_win_close(win, false) end end<CR>:noh<CR>",
	{ silent = true, desc = "Remove Search Highlighting, Dismiss Popups" }
)

-- Better window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>sv", "<cmd>vsplit<cr>", opts)
keymap("n", "<leader>sh", "<cmd>split<cr>", opts)

-- Down is really the next line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Stay in indent mode
--
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- Indenting in visual mode
keymap("x", "<S-TAB>", "<gv", opts)
keymap("x", "<TAB>", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Save
keymap("n", "<C-q>", "<cmd> q! <CR>", opts)
keymap("n", "<C-s>", "<cmd> w <CR>", opts)

-- Select the whole buffer
--
keymap("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })
keymap("n", "<C-a>", "G$vgg0", opts)

-- BlamerToggle
keymap("n", "<Leader>bt", "<cmd>BlamerToggle<cr>", opts)

-- Which Keys
--
keymap("n", "<space>?", "<cmd>WhichKey <CR>", opts)

-- Move current line / block with Alt-j/k a la vscode.
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- LSP finder - Find the symbol's definition
keymap("n", "gI", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "gt", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", "<cmd>FzfLua lsp_references<cr>", opts)
keymap("n", "<space>fx", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>", opts)
keymap(
	"n",
	"gw",
	"<cmd>lua require('fzf-lua').lsp_document_symbols({ reuse_win = true })<CR>",
	opts
)

keymap("n", "<Leader>ci", "<cmd>LspInfo<CR>", opts)
keymap("n", "<Leader>L", "<cmd>Lazy update<CR>", opts)
keymap("n", "<Leader>M", "<cmd>Mason<CR>", opts)
keymap("n", "<Leader>ch", "<cmd>vertical checkhealth<CR>", opts)

-- Vim Arrows remap to do nothing
keymap("n", "<up>", "", opts)
keymap("n", "<down>", "", opts)
keymap("n", "<right>", "", opts)
keymap("n", "<left>", "", opts)
