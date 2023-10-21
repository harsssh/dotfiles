vim.keymap.set('n', '<leader>t', '', {
callback = function()
    if  vim.bo.filetype == 'NvimTree' then
        vim.cmd.wincmd('p')
    else
        vim.cmd('NvimTreeFocus')
    end
end,
})

require('nvim-tree').setup({
    view = {
        width = '30%',
        side = 'right',
        signcolumn = 'no',
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = 'name',
        icons = {
            glyphs = {
                git = {
                    unstaged = '!', renamed = '»', untracked = '?', deleted = '✘',
                    staged = '✓', unmerged = '', ignored = '◌',
                }
            }
        },
    },
})
