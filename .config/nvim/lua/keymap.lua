local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map('i', 'jj', '<ESC>')
map('n', '<ESC><ESC>', ':noh<CR>')
map('n', '<leader>n', ':noh<CR>')

-- UI
map('n', 'rn', function() vim.wo.relativenumber = not vim.wo.relativenumber end, opts)

-- Move
map('n', 'j', 'gj', opts)
map('v', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('v', 'k', 'gk', opts)
map('n', 'H', '0', opts)
map('v', 'H', '0', opts)
map('n', 'L', '$', opts)
map('v', 'L', '$', opts) -- Window
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

-- Resize
-- シフトを押したくない
map('n', 's,', '5<C-w><', opts)
map('n', 's.', '5<C-w>>', opts)
map('n', 's-', '5<C-w>-', opts)
map('n', 's=', '5<C-w>+', opts)
map('n', 's0', '<C-w>=', opts)

-- Edit
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- Yank
map('n', 'Y', 'y$')

-- Paste
map('n', 'p', ']p')
map('n', 'P', ']P')

-- Command
for _, cmd in ipairs({ 'q', 'w', 'qa', 'wq', 'wqa' }) do
  vim.api.nvim_create_user_command(cmd:upper(), cmd, {})
  if #cmd > 2 then
    vim.api.nvim_create_user_command(cmd:sub(1, 1):upper() .. cmd:sub(2), cmd, {})
  end
end

-- Terminal
map('n', 'tt', "<cmd>terminal<CR>", opts)
map('n', 'ts', "<cmd>belowright 15 new<CR><cmd>terminal<CR>", opts)
map('n', 'tv', "<cmd>vertical belowright new<CR><cmd>terminal<CR>", opts)
map('t', '<ESC>', [[<C-\><C-n>]], opts)
