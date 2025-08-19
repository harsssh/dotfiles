return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = "VeryLazy",
    keys = {
      -- mini.bracketed
      { '<leader>l',  '<Cmd>lua MiniBracketed.buffer("forward")<CR>' },
      { '<leader>h',  '<Cmd>lua MiniBracketed.buffer("backward")<CR>' },
      -- mini.bufremove
      { '<leader>bd', '<Cmd>lua MiniBufremove.delete()<CR>' },
      {
        '<leader>bo',
        function()
          local cur = vim.api.nvim_get_current_buf()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if buf ~= cur then
              require("mini.bufremove").delete(buf, false)
            end
          end
        end
      }
    },
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
      require("mini.bufremove").setup()
      require("mini.trailspace").setup()
      require("mini.indentscope").setup({
        draw = { animation = require("mini.indentscope").gen_animation.none() },
        symbol = '▏'
      })

      -- mini.cursorword
      vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    keys = {
      {
        '<leader>ff',
        function() require('telescope.builtin').find_files() end,
        desc = 'Telescope: Find Files'
      },
      {
        '<leader>fg',
        function() require('telescope.builtin').live_grep() end,
        desc = 'Telescope: Live Grep'
      },
      {
        '<leader>fb',
        function() require('telescope.builtin').current_buffer_fuzzy_find() end,
        desc = 'Telescope: Fuzzy Find in Current Buffer'
      }
    },
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
    opts = {
      defaults = {
        layout_strategy = 'vertical',
        layout_config = {
          prompt_position = "top",
          mirror = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }

    }
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
      {
        "<leader>e",
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
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          vim.b.miniindentscope_disable = true
          vim.b.minicursorword_disable = true

          -- window 移動と衝突するので無効化
          vim.keymap.set('n', 's', '<Nop>', { buffer = true, noremap = true, silent = true })
          -- ファイルの場合は何もしない
          vim.keymap.set('n', 'l', '<Plug>(fern-action-expand)', { buffer = true, noremap = true, silent = true })
        end
        ,
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
  {
    'smoka7/hop.nvim',
    version = "*",
    keys = {
      {
        'f',
        function()
          require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })
        end,
        mode = ''
      },
      {
        'F',
        function()
          require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })
        end,
        mode = ''
      },
      {
        't',
        function()
          require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end,
        mode = ''
      },
      {
        'T',
        function()
          require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end,
        mode = ''
      },
    },
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = { "InsertEnter" },
    opts = {}
  }
}
