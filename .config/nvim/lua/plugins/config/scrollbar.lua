local M = {}

M.setup = function()
  local colors = require("kanagawa.colors").setup().palette
  require("scrollbar").setup({
    handle = { color = colors.fujiGray },
    marks = {
      Cursor = { text = '▬' },
      Search = { text = { "▬" }, color = colors.carpYellow },
      Error = { text = { "▬" }, color = colors.samuraiRed },
      Warn = { text = { "▬" }, color = colors.surimiOrange },
      Info = { text = { "▬" }, color = colors.crystalBlue },
      Hint = { text = { "▬" }, color = colors.springGreen },
      Misc = { text = { "▬" }, color = colors.oniViolet },
    }
  })
end

return M
