return {
  {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope: Find Files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope: Live Grep' },
      { '<leader>fb', function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = 'Telescope: Fuzzy Find in Current Buffer' },
      { '<leader>gs', function() require('telescope.builtin').git_status({ show_untracked = true }) end, desc = 'Telescope: Git Status (with untracked)' },
      -- JetBrains の cmd + e を意識
      { '<leader>fe', function() require('telescope.builtin').oldfiles({ prompt_title = "Recent Files" }) end, desc = 'Search Recent Files' },
      {
        '<leader>fs',
        function()
          require('telescope.builtin').lsp_dynamic_workspace_symbols({
            symbols = { "Class", "Function", "Method", "Interface", "Struct", "Module", "Constant", "Enum" }
          })
        end,
      }
    },
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function() require("config.treesitter").setup() end
      },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function() require("config.telescope").setup() end
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
  {
    "lambdalisue/fern.vim",
    lazy = false,
    keys = {
      {
        "-",
        "",
        callback = function()
          if vim.bo.filetype == 'fern' then
            vim.cmd.wincmd 'p'
          else
            vim.cmd.Fern('.', '-reveal=%', '-width=30', '-drawer', '-right')
          end
        end,
        noremap = true,
        silent = true
      },
    },
    init = function()
      vim.g["fern#disable_drawer_smart_quit"] = 1
      vim.g["fern#default_hidden"] = 0
    end,
    config = function() require("config.fern").setup() end,
    dependencies = {
      { 'lambdalisue/nerdfont.vim', },
      {
        'lambdalisue/fern-renderer-nerdfont.vim',
        config = function() vim.g['fern#renderer'] = "nerdfont" end
      },
      { "lambdalisue/fern-git-status.vim" },
      { "lambdalisue/fern-hijack.vim" },
    },
  },
  {
    "folke/persistence.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Stop Persistence" },
    },
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
    },
  },
}
