return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup({
        mappings = {
          -- sh が被るので無効化
          highlight = '',
        },
      })
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
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require("plugins/config/treesitter")
              .setup()
        end
      },
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
  },
  {
    "lambdalisue/fern.vim",
    config = function()
      local init_fern = function()
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
        vim.g['fern#disable_drawer_smart_quit'] = 1

        local map = vim.api.nvim_buf_set_keymap
        local opts = { noremap = true, silent = true }

        -- window 移動と衝突するので無効化
        map(0, 'n', 's', '<Nop>', opts)
        -- ファイルの場合は何もしない
        map(0, 'n', 'l', '<Plug>(fern-action-expand-tree)', opts)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = init_fern,
      })
    end,
  }
}
