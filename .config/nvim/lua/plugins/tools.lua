return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.cursorword").setup()
      require("mini.tabline").setup({ tabpage_section = 'none' })
      require("mini.trailspace").setup()
      require("mini.indentscope").setup({
        draw = { animation = require("mini.indentscope").gen_animation.none() },
        symbol = '▏'
      })

      -- mini.cursorword
      vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })

      -- mini.bracketed
      vim.keymap.set('n', '<leader>l', '<Cmd>lua MiniBracketed.buffer("forward")<CR>', { silent = true, noremap = true })
      vim.keymap.set('n', '<leader>h', '<Cmd>lua MiniBracketed.buffer("backward")<CR>', { silent = true, noremap = true })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("plugins/config/treesitter").setup() end },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
      }
    },
    config = function() require("plugins/config/telescope").setup() end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
}
