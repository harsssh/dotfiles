vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
})

-- local show_error_diagnostics = function()
--   local opts = {
--     focusable = false,
--     style = "minimal",
--     border = "rounded",
--     source = "always",
--     prefix = " ",
--     severity = vim.diagnostic.severity.ERROR
--   }
--   vim.diagnostic.open_float(nil, opts)
-- end
--
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     local diagnostics = vim.diagnostic.get(vim.api.nvim_get_current_buf())
--     for _, diag in ipairs(diagnostics) do
--       if diag.severity == vim.diagnostic.severity.ERROR then
--         show_error_diagnostics()
--         return
--       end
--     end
--   end
-- })

vim.o.updatetime = 300

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    -- vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>')
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  end
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "Red" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "Orange" })
