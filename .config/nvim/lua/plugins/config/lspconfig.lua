local M = {}

M.setup = function()
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")

  require("mason").setup()
  mason_lspconfig.setup()

  mason_lspconfig.setup_handlers {
    function(server_name)
      require("lspconfig")[server_name].setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      }
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
    end,
    ["gopls"] = function()
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })
    end
  }
end

return M
