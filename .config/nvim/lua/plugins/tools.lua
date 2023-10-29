return {
	{
		"nvim-telescope/telescope.nvim",
		event = { 'BufReadPre', 'BufNewFile' },
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build =
				'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ 'RRethy/vim-illuminate' },
	{
		'folke/trouble.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		'42Paris/42header',
		event = { 'BufReadPre', 'BufNewFile' },
	},
	{
		'cacharle/c_formatter_42.vim',
		event = { 'BufReadPre', 'BufNewFile' },
	},
}
