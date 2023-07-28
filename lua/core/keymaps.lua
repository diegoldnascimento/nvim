local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--

-- Better window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Save
keymap("n", "<C-q>", "<cmd> wq <CR>", opts)
keymap("n", "<C-s>", "<cmd> w <CR>", opts)
keymap("n", "<C-w>", "<cmd> BufDel <CR>", opts)

-- Select the whole buffer

keymap("n", "<C-a>", "ggVG", opts)

--Nvim Tree Toggle
keymap("n", "<c-n>", "<cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<c-m>", "<cmd>NvimTreeFocus<CR>", opts)
keymap("n", "<c-k>", "<cmd>NvimTreeFindFile<CR>", opts)
-- Telescope
keymap("n", "<c-p>", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<Space>ff", "<cmd>Telescope find_files<cr>", opts)
keymap(
	"n",
	"<Space>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>",
	opts
)
keymap("n", "<Space>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<Space>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<Space>fp", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<Space>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<Space>fo", "<cmd>Telescope oldfiles<cr>", opts)

-- BlamerToggle
keymap("n", "<Space>bt", "<cmd>BlamerToggle<cr>", opts)

-- Bufferline
keymap("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<A-<>", "<Cmd>BufferLineMovePrevious<CR>", opts)
keymap("n", "<A->>", "<Cmd>BufferLineMoveNext<CR>", opts)
keymap("n", "<Space>1", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<Space>2", "<cmd>BufferLineGoToBuffer 2<cr>", opts)
keymap("n", "<Space>3", "<cmd>BufferLineGoToBuffer 3<cr>", opts)
keymap("n", "<Space>4", "<cmd>BufferLineGoToBuffer 4<cr>", opts)
keymap("n", "<Space>5", "<cmd>BufferLineGoToBuffer 5<cr>", opts)
keymap("n", "<Space>6", "<cmd>BufferLineGoToBuffer 6<cr>", opts)
keymap("n", "<Space>7", "<cmd>BufferLineGoToBuffer 7<cr>", opts)
keymap("n", "<Space>8", "<cmd>BufferLineGoToBuffer 8<cr>", opts)
keymap("n", "<Space>9", "<cmd>BufferLineGoToBuffer 9<cr>", opts)
keymap("n", "<Space>c", "<cmd>BufferLineCloseLeft<cr>", opts)
keymap("n", "<Space>w", "<cmd>BufferLinePickClose<cr>", opts)
keymap("n", "<Space>bb", "<cmd>BufferOrderByBufferNumber<cr>", opts)
keymap("n", "<Space>bd", "<cmd>BufferOrderByDirectory<cr>", opts)
keymap("n", "<Space>bl", "<cmd>BufferOrderByLanguage<cr>", opts)
keymap("n", "<Space>bw", "<cmd>BufferOrderByWindowNumber<cr>", opts)

-- Which Keys
--
keymap("n", "<space>?", "<cmd>WhichKey <CR>", opts)

-- Comments
keymap("n", "<C-_>", "<Cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)

-- Move current line / block with Alt-j/k a la vscode.
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- LSP finder - Find the symbol's definition
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap(
	"n",
	"gd",
	"<cmd>lua require('telescope.builtin').lsp_definitions({ reuse_win = true })<CR>",
	opts
)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap(
	"n",
	"gi",
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
keymap("n", "gx", "<cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>", opts)
keymap(
	"n",
	"gw",
	"<cmd>lua require('telescope.builtin').lsp_document_symbols({ reuse_win = true })<CR>",
	opts
)

keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "X", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<Space>cl", "<cmd>LspInfo<CR>", opts)
