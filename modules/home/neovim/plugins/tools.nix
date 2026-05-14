{
  programs.nixvim = {
    plugins = {
      persistence = {
        enable = true;
        settings.dir.__raw = ''vim.fn.stdpath("state") .. "/sessions/"'';
      };

      toggleterm = {
        enable = true;
        settings = {
          persist_mode = true;
          persist_size = true;
          start_in_insert = true;
          float_opts = {
            border = "curved";
            width.__raw = "function() return math.floor(vim.o.columns * 0.8) end";
            height.__raw = "function() return math.floor(vim.o.lines * 0.8) end";
          };
        };
      };

      tmux-navigator = {
        enable = true;
        settings.no_wrap = 1;
      };

      none-ls = {
        enable = true;
        sources.formatting = {
          rubocop.enable = true;
          biome.enable = true;
          stylua.enable = true;
          gofumpt.enable = true;
          goimports.enable = true;
        };
      };
    };

    keymaps = [
      # Persistence
      { mode = "n"; key = "<leader>qs"; action.__raw = "function() require('persistence').load() end"; options.desc = "Restore Session"; }
      { mode = "n"; key = "<leader>qS"; action.__raw = "function() require('persistence').select() end"; options.desc = "Select Session"; }
      { mode = "n"; key = "<leader>ql"; action.__raw = "function() require('persistence').load({ last = true }) end"; options.desc = "Restore Last Session"; }
      { mode = "n"; key = "<leader>qd"; action.__raw = "function() require('persistence').stop() end"; options.desc = "Stop Persistence"; }

      # Toggleterm
      { mode = "n"; key = "<leader>tt"; action = "<cmd>ToggleTerm direction=float<cr>"; options.desc = "Toggle floating terminal"; }
      { mode = "n"; key = "<leader>ts"; action = "<cmd>ToggleTerm direction=horizontal size=15<cr>"; options.desc = "Toggle horizontal terminal"; }
      { mode = "n"; key = "<leader>tv"; action = "<cmd>ToggleTerm direction=vertical size=80<cr>"; options.desc = "Toggle vertical terminal"; }
      { mode = "n"; key = "<C-\\>"; action = "<cmd>ToggleTerm<cr>"; options.desc = "Toggle terminal"; }
      { mode = "t"; key = "<C-\\>"; action = "<C-\\><C-n><cmd>ToggleTerm<cr>"; options.desc = "Toggle terminal (term mode)"; }
      { mode = "t"; key = "<ESC>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }

      # tmux-navigator
      { mode = "n"; key = "<C-h>"; action = "<cmd>TmuxNavigateLeft<cr>"; options.desc = "Navigate left"; }
      { mode = "n"; key = "<C-j>"; action = "<cmd>TmuxNavigateDown<cr>"; options.desc = "Navigate down"; }
      { mode = "n"; key = "<C-k>"; action = "<cmd>TmuxNavigateUp<cr>"; options.desc = "Navigate up"; }
      { mode = "n"; key = "<C-l>"; action = "<cmd>TmuxNavigateRight<cr>"; options.desc = "Navigate right"; }
      { mode = "n"; key = "<C-p>"; action = "<cmd>TmuxNavigatePrevious<cr>"; options.desc = "Navigate previous"; }
    ];

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
