local M = {}

M.setup = function()
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

      -- fern 内でも vim-tmux-navigator を使ってウィンドウ移動を可能にする
      -- tmux 環境では tmux pane への移動も可能
      vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { buffer = true, noremap = true, silent = true })
      vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { buffer = true, noremap = true, silent = true })
      vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { buffer = true, noremap = true, silent = true })
      vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { buffer = true, noremap = true, silent = true })
    end,
  })
end

return M