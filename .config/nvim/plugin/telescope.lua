local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup({
    defaults = {
        winblend = 4,
        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.6,
        },
        file_ignore_patterns = {
            '.git/',
            'node_modules/'
        },
    },
    extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
		}
	},
})

require('telescope').load_extension('fzf')
