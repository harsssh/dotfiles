local M = {}

function M.setup()
  local null_ls = require("null-ls")
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            if vim.bo.modified then
              vim.lsp.buf.format({ async = true })
            end
          end
        })
      end
    end,
    sources = {
      null_ls.builtins.formatting.rubocop,
      null_ls.builtins.formatting.biome,
    },
  })
end

return M
