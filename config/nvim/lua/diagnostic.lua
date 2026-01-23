vim.diagnostic.config({
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    }
  },
  signs = false,
  underline = true,
  update_in_insert = false,
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#FF5555" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#FFAA00" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#61AFEF" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#98C379" })
