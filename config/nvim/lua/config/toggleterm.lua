local M = {}

function M.setup()
  require("toggleterm").setup({
    float_opts = {
      border = "curved",
      width = function() return math.floor(vim.o.columns * 0.8) end,
      height = function() return math.floor(vim.o.lines * 0.8) end,
    },
    persist_mode = true,
    persist_size = true,
    start_in_insert = true,
  })
end

return M
