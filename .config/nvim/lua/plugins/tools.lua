return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = "VeryLazy",
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
      require("mini.tabline").setup({ tabpage_section = 'right' })
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
    cmd = "Telescope",
    event = { "VimEnter" },
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
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
    lazy = false,
    keys = {
      { "<leader>e", ":Fern . -reveal=% -width=30 -drawer -right<CR>", noremap = true, silent = true },
    },
    config = function()
      local init_fern = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.b.miniindentscope_disable = true
        vim.b.minicursorword_disable = true

        vim.g["fern#disable_drawer_smart_quit"] = 1

        vim.keymap.set('n', '<leader>e', '', {
          callback = function()
            if vim.bo.filetype == 'fern' then
              vim.cmd.wincmd 'p'
            else
              vim.cmd.Fern('.', '-reveal=%', '-width=30', '-drawer', '-right')
            end
          end,
          noremap = true,
          silent = true,
        })


        local map = vim.api.nvim_buf_set_keymap
        local opts = { noremap = true, silent = true }

        -- window 移動と衝突するので無効化
        map(0, 'n', 's', '<Nop>', opts)
        -- ファイルの場合は何もしない
        map(0, 'n', 'l', '<Plug>(fern-action-expand)', opts)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = init_fern,
      })
    end,
    dependencies = {
      { 'lambdalisue/nerdfont.vim', },
      {
        'lambdalisue/fern-renderer-nerdfont.vim',
        config = function()
          vim.g['fern#renderer'] = "nerdfont"
        end
      },
      { "lambdalisue/fern-git-status.vim" },
      { "lambdalisue/fern-hijack.vim" },
    },
  },
  { "tpope/vim-repeat", event = { "BufReadPost", "BufNewFile" } },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
      vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)
    end,
  },
}
