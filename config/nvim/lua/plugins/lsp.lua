return {
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspStart", "LspStop" },
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function() require("config.none-ls").setup() end,
  },
}
