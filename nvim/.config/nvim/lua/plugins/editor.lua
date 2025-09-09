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
    config = function() require("config.mini").setup() end,
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
  { "tpope/vim-repeat", event = { "BufReadPost", "BufNewFile" } },
  {
    'windwp/nvim-ts-autotag',
    event = { "InsertEnter" },
    opts = {}
  }
}