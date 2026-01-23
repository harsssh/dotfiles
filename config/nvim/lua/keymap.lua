local map = vim.keymap.set
local silent = { silent = true }

-- General
map('i', 'jj', '<ESC>')
map('n', '<leader>n', ':noh<CR>')

-- UI
map('n', 'rn', function() vim.wo.relativenumber = not vim.wo.relativenumber end, silent)

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
-- tmux 環境外でも Ctrl+hjkl でウィンドウ移動できるようにする
-- tmux 環境では vim-tmux-navigator が優先される
if vim.env.TMUX == nil then
  map('n', '<C-h>', '<C-w>h')
  map('n', '<C-j>', '<C-w>j')
  map('n', '<C-k>', '<C-w>k')
  map('n', '<C-l>', '<C-w>l')
end
map('n', 'sH', '<C-w>H')
map('n', 'sJ', '<C-w>J')
map('n', 'sK', '<C-w>K')
map('n', 'sL', '<C-w>L')
map('n', 'ss', ':split<CR><C-w>w')
map('n', 'sv', ':vsplit<CR><C-w>w')

-- Resize
-- シフトを押したくない
-- vim-repeat で繰り返し可能にする
local function repeatable_resize(resize_cmd, key)
  return function()
    vim.cmd(resize_cmd)
    pcall(vim.fn['repeat#set'], key, vim.v.count)
  end
end
map('n', 's,', repeatable_resize('vertical resize -3', 's,'), silent)
map('n', 's.', repeatable_resize('vertical resize +3', 's.'), silent)
map('n', 's-', repeatable_resize('resize -3', 's-'), silent)
map('n', 's=', repeatable_resize('resize +3', 's='), silent)
map('n', 's0', '<C-w>=', silent)

-- Edit
-- map('n', '+', '<C-a>')
-- map('n', '-', '<C-x>')

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

-- Others
-- format の gf が邪魔
vim.g.no_ruby_maps = 1
