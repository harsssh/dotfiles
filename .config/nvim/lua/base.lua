-- Basic Settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.mapleader = ' '
vim.wo.number = true
vim.opt.virtualedit = 'all'
vim.opt.showtabline = 2
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = 'unnamedplus'

-- Spaces
vim.opt.tabstop = 4         -- Tab character display width
vim.opt.shiftwidth = 4      -- Indent width inserted automatically
vim.opt.softtabstop = 0     -- Indent width inserted by tab
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.list = true
vim.opt.listchars = {
    --tab='▸-',
    tab='  ',
    trail='-', eol='↲', extends='›', precedes='‹', nbsp='%'
}

-- Indent
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.smarttab = true

-- Enable Syntax Highlighting
vim.cmd [[syntax enable]]

-- Search Settings
vim.opt.incsearch = true          -- Enable incremental search
vim.opt.hlsearch = true           -- Highlight search results
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable Backup and Swap
vim.opt.backup = false            -- Disable backup
vim.opt.swapfile = false          -- Disable swap file

-- LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
