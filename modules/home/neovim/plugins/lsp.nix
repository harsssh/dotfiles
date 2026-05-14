{
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      sources.formatting = {
        rubocop.enable = true;
        biome.enable = true;
        stylua.enable = true;
        gofumpt.enable = true;
        goimports.enable = true;
      };
    };

    # none-ls の保存時フォーマット (旧 format_then_write)
    extraConfigLuaPost = ''
      local null_ls_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = null_ls_group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or client.name ~= "null-ls" then return end
          if not client.supports_method("textDocument/formatting") then return end

          vim.api.nvim_clear_autocmds({ group = null_ls_group, buffer = args.buf })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = null_ls_group,
            buffer = args.buf,
            callback = function(ev)
              if not vim.bo.modified then return end
              local bufnr = ev.buf
              local clients = vim.lsp.get_clients({ bufnr = bufnr })
              local target
              for _, c in ipairs(clients) do
                if c.supports_method("textDocument/formatting", bufnr) then
                  if c.name == "null-ls" then target = c; break end
                  target = target or c
                end
              end
              if not target then
                vim.cmd("silent keepjumps noautocmd write")
                return
              end
              local params = vim.lsp.util.make_formatting_params()
              target.request("textDocument/formatting", params, function(err, result, ctx)
                if err then
                  vim.notify(("formatting error (%s): %s"):format(target.name, err.message or err), vim.log.levels.WARN)
                  vim.cmd("silent keepjumps noautocmd write")
                  return
                end
                if result and vim.api.nvim_buf_is_loaded(ctx.bufnr) then
                  local enc = target.offset_encoding or "utf-16"
                  vim.lsp.util.apply_text_edits(result, ctx.bufnr, enc)
                end
                vim.cmd("silent keepjumps noautocmd write")
              end, bufnr)
            end,
          })
        end,
      })
    '';
  };
}
