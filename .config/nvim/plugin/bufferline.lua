local bufferline = require('bufferline')
bufferline.setup({
    options = {
        style_preset = bufferline.style_preset.no_italic,
    }
})

local silent = { silent = true }
vim.keymap.set('n', '<leader>l', ':BufferLineCycleNext<CR>', silent)
vim.keymap.set('n', '<leader>h', ':BufferLineCyclePrev<CR>', silent)
vim.keymap.set('n', '<leader>p', ':BufferLinePick<CR>', silent)
vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', silent)
vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', silent)
