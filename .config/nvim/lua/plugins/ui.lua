return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function() vim.cmd('colorscheme kanagawa') end,
    },
	--[[
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function() vim.cmd('colorscheme tokyonight-night') end,
	},
	]]
    {
		'nvim-lualine/lualine.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = 'nvim-tree/nvim-web-devicons',
	},
    {
	    'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
	},
	{ 'mhinz/vim-startify', event = 'VimEnter' },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' },
    { 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach', opts = {} },
    { 'kevinhwang91/nvim-hlslens', opts = {} },
    {
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {}
	},
    {
		'akinsho/bufferline.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons'
	},
}
