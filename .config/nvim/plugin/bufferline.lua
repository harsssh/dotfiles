local bufferline = require('bufferline')
bufferline.setup({
    options = {
        style_preset = bufferline.style_preset.no_italic,
    }
})

local silent = { silent = true }
vim.keymap.set('n', '<leader>]', ':BufferLineCycleNext<CR>', silent)
vim.keymap.set('n', '<leader>[', ':BufferLineCyclePrev<CR>', silent)
vim.keymap.set('n', '<leader>p', ':BufferLinePick<CR>', silent)
vim.keymap.set('n', '<leader>q', ':BufferLinePickClose<CR>', silent)
vim.keymap.set('n', '<leader>x', ':BufferLineCloseOthers<CR>', silent)
