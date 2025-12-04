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
          local deleted_count = 0
          
          -- リストされているバッファを全て取得
          local bufs = vim.api.nvim_list_bufs()
          
          for _, buf in ipairs(bufs) do
            -- 現在のバッファ以外で、有効かつリストされているバッファを削除
            if buf ~= cur 
               and vim.api.nvim_buf_is_valid(buf) 
               and vim.bo[buf].buflisted then
              local ok = pcall(require("mini.bufremove").delete, buf, false)
              if ok then
                deleted_count = deleted_count + 1
              end
            end
          end
          
          -- 削除結果を通知（オプション）
          if deleted_count > 0 then
            vim.notify(string.format("Deleted %d buffer(s)", deleted_count))
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
  { "neovimhaskell/haskell-vim", ft = { "haskell", "lhaskell", "cabal" } },
  {
    'windwp/nvim-ts-autotag',
    event = { "InsertEnter" },
    opts = {}
  }
}