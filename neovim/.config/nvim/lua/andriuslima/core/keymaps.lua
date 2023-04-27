local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window management
keymap("n", "<C-h>", "<C-w>h", opts) -- Go to left
keymap("n", "<C-j>", "<C-w>j", opts) -- Go to bottom
keymap("n", "<C-k>", "<C-w>k", opts) -- Go to top
keymap("n", "<C-l>", "<C-w>l", opts) -- Go to rigth

-- Resize with arrows
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<S-j>", ":m .+1<CR>==", opts)
keymap("v", "<S-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Explorer
keymap("n", "<A-/>", "<cmd>NvimTreeToggle<CR>", opts)

-- Buffers (tabs)
keymap("n", "<C-s>", ":w<CR>", opts) -- Save buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-w>", ":Bdelete!<CR>", opts) -- Close buffer
keymap(
	"n",
	"<C-e>",
	"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
	opts
)
