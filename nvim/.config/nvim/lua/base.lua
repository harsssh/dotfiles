vim.g.mapleader = ' '

vim.opt.syntax = "on"

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.showtabline = 2
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.pumheight = 12
vim.opt.scrolloff = 4

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.timeoutlen = 300
vim.opt.updatetime = 300

vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.smarttab = true
vim.opt.autoindent = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.undodir = vim.fn.expand('~/.config/nvim/undo')
vim.opt.undofile = true

vim.opt.clipboard:append({ 'unnamedplus' })
