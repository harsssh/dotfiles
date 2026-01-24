vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local servers = { 'ts_ls', 'lua_ls', 'gopls' }
vim.lsp.enable(servers)
