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
    config = function()
      require("mason").setup()
      require('mason-lspconfig')
          .setup {
            automatic_installation = true,
            ensure_installed = { 'ts_ls', 'lua_ls', 'gopls' },
          }
    end
  },
}
