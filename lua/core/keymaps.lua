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

-- Remap Enter key to do nothing
keymap("n", "<CR>", "<NOP>", opts)
keymap("v", "<CR>", "<NOP>", opts)

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

-- Move to the end of yanked text after yank and paste
keymap('n', 'p', 'p`]', opts)
keymap('x', 'y', 'y`]', opts)
keymap('x', 'p', 'p`]', opts)

-- Stay in indent mode
--
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- Indenting in visual mode
keymap('x', '<S-TAB>', '<gv', opts)
keymap('x', '<TAB>', '>gv', opts)

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

keymap("n", "<C-a>", "G$vgg0", opts)

-- Telescope
keymap("n", "<c-p>", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap(
	"n",
	"<Leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>",
	opts
)
keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap(
	"n",
	"<Leader>fG",
	"<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={'%:p'} }<cr>",
	opts
)
keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<Leader>fo", "<cmd>Telescope oldfiles<cr>", opts)

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
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap(
	"n",
	"gI",
	"<cmd>lua require('telescope.builtin').lsp_implementations({ reuse_win = true })<CR>",
	opts
)
keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap(
	"n",
	"gt",
	"<cmd>lua require('telescope.builtin').lsp_type_definitions({ reuse_win = true })<CR>",
	opts
)
keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
keymap(
	"n",
	"<space>fx",
	"<cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>",
	opts
)
keymap(
	"n",
	"gw",
	"<cmd>lua require('telescope.builtin').lsp_document_symbols({ reuse_win = true })<CR>",
	opts
)

keymap("n", "<Leader>cl", "<cmd>LspInfo<CR>", opts)
keymap("n", "<Leader>cm", "<cmd>Mason<CR>", opts)

-- Vim Arrows remap to do nothing
keymap("n", "<up>", "", opts)
keymap("n", "<down>", "", opts)
keymap("n", "<right>", "", opts)
keymap("n", "<left>", "", opts)
