vim.keymap.set('n', '<leader>t', '', {
	callback = function()
		if  vim.bo.filetype == 'NvimTree' then
			vim.cmd.wincmd('p')
		else
			vim.cmd('NvimTreeFocus')
		end
	end,
})

local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.del('n', 's', { buffer = bufnr })
end

require('nvim-tree').setup({
	on_attach = my_on_attach,
    view = {
        width = '30%',
        side = 'right',
        signcolumn = 'no',
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = 'name',
        icons = {
            glyphs = {
                git = {
                    unstaged = '!', renamed = '»', untracked = '?', deleted = '✘',
                    staged = '✓', unmerged = '', ignored = '◌',
                }
            }
        },
    },
})
