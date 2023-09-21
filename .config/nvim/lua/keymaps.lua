local map = vim.keymap.set
local opts = { noremap = true }

-- ハイライトを解除
map('n', '<ESC><ESC>', ':nohlsearch<CR>', { noremap = true, silent = true })

map('n', 'x', '"_x', opts)
map('n', 's', '"_s', opts)

map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('v', 'j', 'gj', opts)
map('v', 'k', 'gk', opts)

-- 画面分割
map('n', 's', 'nop', opts)
map('n', 'sg', 'nop', opts)
map('n', 'sh', '<C-w>h', opts)
map('n', 'sj', '<C-w>j', opts)
map('n', 'sk', '<C-w>k', opts)
map('n', 'sl', '<C-w>l', opts)
map('n', 'sH', '<C-w>H', opts)
map('n', 'sJ', '<C-w>J', opts)
map('n', 'sK', '<C-w>K', opts)
map('n', 'sL', '<C-w>L', opts)

map('n', 'ss', ':split<Return><C-w>w', opts)
map('n', 'sv', ':vsplit<Return><C-w>w', opts)

-- アクティブウィンドウの移動
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- ターミナルモードの設定
map('n', 'tt', '<cmd>belowright 14split<CR><cmd>terminal zsh --no-rcs<CR>', { noremap = true, silent = true })
map('n', 'tn', '<cmd>terminal zsh --no-rcs<CR>', { noremap = true, silent = true })
map('t', '<ESC>', '<C-\\><C-n>', opts)

map('i','jj','<Esc>', opts)
map('n', '<CR>', 'o', opts)
