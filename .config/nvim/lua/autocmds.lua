local augroup = vim.api.nvim_creat_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove whitespace on save
autocmd('BufWritePre', {
    pattern = '*',
    command = ':%s/\\s\\+$//e',
})

-- Do not auto commenting new lines
autocmd('BufEnter', {
    pattern = '*',
    command = 'set fo-=c fo-=r fo-=o',
})

-- Restore  cursor location when file is opend
autocmd({ 'BufReadPost' }, {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
