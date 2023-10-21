local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

local map = vim.keymap.set
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup({
    defaults = {
        winblend = 4,
        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.6,
        },
        file_ignore_patterns = {
            '.git/',
            'node_modules/'
        },
    },
    extensions = {},
})
