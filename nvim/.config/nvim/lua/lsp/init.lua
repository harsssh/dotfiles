vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
vim.lsp.enable(require('mason-lspconfig').get_installed_servers())

