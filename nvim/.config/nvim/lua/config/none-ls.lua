local M = {}

function M.setup()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.rubocop.with({
        command = "rubocop",
        args = { "--auto-correct-all", "--stdin", "$FILENAME", "--stderr" },
      }),
    },
  })
end

return M