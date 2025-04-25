return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function ()
      require("mason").setup()

      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup {
        automatic_installation = true,
        ensure_installed = {'ts_ls', 'lua_ls', 'gopls'},
      }

      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
      vim.lsp.enable(mason_lspconfig.get_installed_servers())
    end
  },
}
