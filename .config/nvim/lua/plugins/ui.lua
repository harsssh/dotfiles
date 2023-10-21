return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme kanagawa]])
        end,
    },
    { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },
    'mhinz/vim-startify',
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    { 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach', opts = {} },
    { 'kevinhwang91/nvim-hlslens', opts = {} },
    { 'lewis6991/gitsigns.nvim', opts = {} },
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
}
