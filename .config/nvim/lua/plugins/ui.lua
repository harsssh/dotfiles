return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme("kanagawa-dragon") end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require("plugins/config/lualine").setup() end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = { signcolumn = true }
  },
  { "petertriho/nvim-scrollbar", config = function() require("plugins/config/scrollbar").setup() end },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
  },
  { "j-hui/fidget.nvim",         opts = {} },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false }
  },
  { "mhinz/vim-startify" }
}
