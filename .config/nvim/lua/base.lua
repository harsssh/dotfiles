-- Standard Plugins
vim.g.loaded_netrw              = 1
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu   = 1
vim.g.did_indent_on             = 1
vim.g.did_load_ftplugin         = 1
vim.g.loaded_2html_plugin       = 1
vim.g.loaded_gzip               = 1
vim.g.loaded_matchit            = 1
vim.g.loaded_matchparen         = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_remote_plugins     = 1
vim.g.loaded_shada_plugin       = 1
vim.g.loaded_spellfile_plugin   = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_tutor_mode_plugin  = 1
vim.g.loaded_zipPlugin          = 1
vim.g.skip_loading_mswin        = 1

-- Basic Settings
vim.opt.termguicolors	= true
vim.g.mapleader         = ' '
vim.wo.number           = true
vim.opt.virtualedit     = 'all'
vim.opt.showtabline     = 2
vim.opt.signcolumn      = 'yes'
vim.opt.clipboard       = 'unnamedplus'

-- Spaces
vim.opt.tabstop		= 4 -- Tab character display width
vim.opt.shiftwidth	= 4 -- Indent width inserted automatically
vim.opt.list        = true
vim.opt.listchars   = {
	--tab='▸-',
	tab = '  ',
	trail = '-',
	eol = '↲',
	extends = '›',
	precedes = '‹',
	nbsp = '%'
}

-- Indent
vim.opt.smartindent	= true
vim.opt.breakindent	= true
vim.opt.smarttab	= true
vim.opt.autoindent	= true

-- Enable Syntax Highlighting
vim.cmd('syntax enable')

-- Search Settings
vim.opt.incsearch = true -- Enable incremental search
vim.opt.hlsearch = true  -- Highlight search results
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable Backup and Swap
vim.opt.backup = false   -- Disable backup
vim.opt.swapfile = false -- Disable swap file
