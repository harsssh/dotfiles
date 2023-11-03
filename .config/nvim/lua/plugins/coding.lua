return {
	{ 'echasnovski/mini.surround', event = 'ModeChanged' },
	{ 'numToStr/Comment.nvim', event = 'InsertEnter', opts = {} },
	{ 'echasnovski/mini.pairs', event = 'VeryLazy', opts = {} },
	{ 'hrsh7th/vim-vsnip', event = 'InsertEnter' },
	{
		'hrsh7th/nvim-cmp',
		event = { 'InsertEnter', 'CmdlineEnter' },
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'onsails/lspkind.nvim',
		}
	},
}
