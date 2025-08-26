local M = {}

M.setup = function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "go", "rust", "haskell", "scala", "lua", "typescript", "javascript" },
    sync_install = false,
    ignore_install = {},
    modules = {},
    auto_install = true,
    highlight = { 
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end

return M
