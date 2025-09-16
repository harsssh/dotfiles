local M = {}

local function format_then_write(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- null-ls を優先（なければ最初の format 可能なクライアントを使用）
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local target_client
  for _, c in ipairs(clients) do
    if c.supports_method("textDocument/formatting", bufnr) then
      if c.name == "null-ls" then
        target_client = c
        break
      end
      target_client = target_client or c
    end
  end

  if not target_client then
    -- フォーマッタがなければそのまま保存
    vim.cmd("silent keepjumps noautocmd write")
    return
  end

  local params = vim.lsp.util.make_formatting_params()
  target_client.request("textDocument/formatting", params, function(err, result, ctx)
    if err then
      vim.notify(("formatting error (%s): %s"):format(target_client.name, err.message or err), vim.log.levels.WARN)
      -- 失敗しても保存はする
      vim.cmd("silent keepjumps noautocmd write")
      return
    end

    if result and vim.api.nvim_buf_is_loaded(ctx.bufnr) then
      local enc = target_client.offset_encoding or "utf-16"
      vim.lsp.util.apply_text_edits(result, ctx.bufnr, enc)
      -- フォーマットで変更が入ったので書き込み
      vim.cmd("silent keepjumps noautocmd write")
    else
      -- 変更なしでも保存する
      vim.cmd("silent keepjumps noautocmd write")
    end
  end, bufnr)
end

function M.setup()
  local null_ls = require("null-ls")
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function(args)
            if vim.bo.modified then
              -- vim.lsp.buf.format({ async = true })
              format_then_write(args.buf)
            end
          end,
        })
      end
    end,
    sources = {
      null_ls.builtins.formatting.rubocop.with({
        args = { "-f", "json", "--force-exclusion", "-A", "--stdin", "$FILENAME" },
      }),
      null_ls.builtins.formatting.biome,
      null_ls.builtins.formatting.stylua,
    },
  })
end

return M
