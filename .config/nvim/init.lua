require('base')
require('autocmds')
require('keymaps')
require('plugins')

vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = { 'plugins.lua' },
	command = 'PackerCompile',
})
