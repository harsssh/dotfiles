local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      require("lspconfig")[server_name].setup {}
    end,

    ["rust_analyzer"] = function()
      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust_analyzer'] = {
            check = {
              command = "clippy",
            },
          },
        },
      })
    end
  }
end

return M
