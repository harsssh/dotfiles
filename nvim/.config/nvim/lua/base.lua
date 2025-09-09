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

-- Performance optimizations
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 200

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

vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undofile = true

vim.opt.clipboard:append({ 'unnamedplus' })

-- Folding settings
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldenable = true

vim.g.loaded_ruby_provider   = 0
vim.g.loaded_node_provider   = 0
vim.g.loaded_perl_provider   = 0
vim.g.loaded_python_provider = 0
