local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map('i', 'jj', '<ESC>')
map('n', '<leader>n', ':noh<CR>')

-- Move
map('n', 'j', 'gj', opts)
map('v', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('v', 'k', 'gk', opts)
map('n', 'H', '0', opts)
map('v', 'H', '0', opts)
map('n', 'L', '$', opts)
map('v', 'L', '$', opts)

-- Window
map('n', 'sh', '<C-w>h')
map('n', 'sj', '<C-w>j')
map('n', 'sk', '<C-w>k')
map('n', 'sl', '<C-w>l')
map('n', 'sH', '<C-w>H')
map('n', 'sJ', '<C-w>J')
map('n', 'sK', '<C-w>K')
map('n', 'sL', '<C-w>L')
map('n', 'ss', ':split<CR><C-w>w')
map('n', 'sv', ':vsplit<CR><C-w>w')

-- Edit
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- Yank
map('n', 'Y', 'y$')

-- Paste
map('n', 'p', ']p')
map('n', 'P', ']P')

