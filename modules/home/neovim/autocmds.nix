{
  programs.nixvim = {
    autoGroups = {
      MyTerminal.clear = true;
      AutoReload.clear = true;
      HelpDisplay.clear = true;
      RestoreCursor.clear = true;
      LspKeymaps.clear = true;
      RubyIndent.clear = true;
      ExplorerTmuxNav.clear = true;
    };

    autoCmd = [
      {
        event = [ "TermOpen" ];
        group = "MyTerminal";
        pattern = "*";
        callback.__raw = ''
          function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.signcolumn = 'no'
          end
        '';
      }
      {
        event = [ "WinEnter" "FocusGained" "BufEnter" "CursorHold" ];
        group = "AutoReload";
        pattern = "*";
        command = "checktime";
      }
      {
        event = [ "FileType" ];
        group = "HelpDisplay";
        pattern = [ "help" "man" "qf" "lspinfo" "checkhealth" ];
        callback.__raw = ''
          function()
            vim.opt_local.signcolumn = 'no'
          end
        '';
      }
      {
        event = [ "BufReadPost" ];
        group = "RestoreCursor";
        pattern = "*";
        callback.__raw = ''
          function()
            local mark = vim.fn.line("'\"")
            if mark > 1 and mark <= vim.fn.line("$") then
              vim.cmd('normal! g`"')
            end
          end
        '';
      }
      {
        event = [ "FileType" ];
        group = "RubyIndent";
        pattern = [ "ruby" ];
        callback.__raw = ''
          function()
            vim.schedule(function()
              vim.opt_local.indentexpr = "GetRubyIndent()"
            end)
          end
        '';
      }
      {
        event = [ "BufWinEnter" ];
        group = "ExplorerTmuxNav";
        pattern = [ "*" ];
        callback.__raw = ''
          function(ev)
            if vim.bo[ev.buf].filetype ~= "snacks_picker_list" then return end
            -- explorer は split (non-floating), 他の picker は floating window
            local win = vim.api.nvim_get_current_win()
            if vim.api.nvim_win_get_config(win).relative ~= "" then return end
            -- snacks がキーマップを設定し終えた後に上書きする
            vim.schedule(function()
              local map = vim.keymap.set
              local opts = { buffer = ev.buf, nowait = true, silent = true }
              map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  opts)
              map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>",  opts)
              map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>",    opts)
              map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)
            end)
          end
        '';
      }
      {
        event = [ "LspAttach" ];
        group = "LspKeymaps";
        callback.__raw = ''
          function(args)
            local bufnr = args.buf
            local opts  = { buffer = bufnr, silent = true }
            local map   = vim.keymap.set
            map('n', 'K', vim.lsp.buf.hover, opts)
            map('n', 'ge', vim.diagnostic.open_float, opts)
            map('n', 'g]', function()
              vim.diagnostic.jump({ count = 1, forward = true })
            end, opts)
            map('n', 'g[', function()
              vim.diagnostic.jump({ count = 1, forward = false })
            end, opts)
            map('n', 'gf', vim.lsp.buf.format, opts)
            map('n', 'gn', vim.lsp.buf.rename, opts)
            map('n', 'ga', vim.lsp.buf.code_action, opts)
          end
        '';
      }
    ];
  };
}
