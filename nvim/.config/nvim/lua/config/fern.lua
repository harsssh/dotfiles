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
    end,
  })
end

return M