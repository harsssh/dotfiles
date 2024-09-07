if vim.g.vscode then
  require("base")
  require("keymap")
else
  require("init_lazy")
  require("base")
  require("keymap")
  require("autocmd")
  require("diagnostic")

  require("lazy").setup("plugins", {
    defaults = {
      lazy = true,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      }
    }
  })
end
