local M = {}

M.setup = function()
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
end

return M