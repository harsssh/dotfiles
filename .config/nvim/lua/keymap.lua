local map = vim.keymap.set
local silent = { silent = true }

-- General
map('i', 'jj', '<ESC>')
map('n', '<leader>n', ':noh<CR>')

-- Move
map('n', 'j', 'gj', silent)
map('v', 'j', 'gj', silent)
map('n', 'k', 'gk', silent)
map('v', 'k', 'gk', silent)
map('n', 'H', '0', silent)
map('v', 'H', '0', silent)
map('n', 'L', '$', silent)
map('v', 'L', '$', silent)

-- Window
map('n', 'sh', '<C-w>h')
map('n', 'sj', '<C-w>j')
map('n', 'sk', '<C-w>k')
map('n', 'sl', '<C-w>l')
map('n', 'sH', '<C-w>H')
map('n', 'sJ', '<C-w>J')
map('n', 'sK', '<C-w>K')
map('n', 'sL', '<C-w>L')
map('n', 'ss', 'split<CR><C-w>w')
map('n', 'sv', 'vsplit<CR><C-w>w')

-- Edit
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- Yank
map('n', 'Y', 'y$')

-- Paste
map('n', 'p', ']p')
map('n', 'P', ']P')
