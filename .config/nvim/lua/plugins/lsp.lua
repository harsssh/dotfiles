return {
  {
    "williamboman/mason.nvim",
    opts = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = true,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function() require("plugins/config/lspconfig").setup() end,
  },
}
