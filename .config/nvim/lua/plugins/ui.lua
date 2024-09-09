return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme("kanagawa-dragon") end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require("plugins/config/lualine").setup() end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = { signcolumn = true }
  },
  { "petertriho/nvim-scrollbar", event = "BufReadPost", config = function() require("plugins/config/scrollbar").setup() end },
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPre",
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
  },
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false }
  },
  { "mhinz/vim-startify", event = 'VimEnter' },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.cmd([[ hi TreesitterContextBottom gui=underline guisp=Grey ]])
      vim.cmd([[ hi TreesitterContextLineNumberBottom gui=underline guisp=Grey ]])
    end,
  },
}
