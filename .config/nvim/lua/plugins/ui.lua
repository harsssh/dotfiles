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
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPre",
    opts = {},
  },
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false }
  },
  {
    "mhinz/vim-startify",
    event = 'VimEnter',
    config = function()
      vim.g.startify_session_dir = vim.fn.stdpath("state") .. "/sessions/"
      vim.g.startify_files_number = 5
    end
  },
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
  {
    'rcarriga/nvim-notify',
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        max_width = 45,
      })
      vim.notify = notify
    end,
  }
}
