return {
  {
    "folke/lazydev.nvim",
    ft = { "lua" }, -- only load on lua files
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      {
        "zbirenbaum/copilot-cmp",
        event = { "InsertEnter", "LspAttach" },
        config = function()
          require("copilot_cmp").setup()
        end
      },
    },
    config = function() require("plugins/config/cmp").setup() end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- 手動で有効化する必要がある
    -- event = { "InsertEnter", "LspAttach" },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
}
