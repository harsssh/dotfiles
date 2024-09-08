return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function() require("plugins/config/lspconfig").setup() end,
  },
}
