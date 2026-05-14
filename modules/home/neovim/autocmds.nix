{
  programs.nixvim = {
    autoGroups = {
      MyTerminal.clear = true;
      AutoReload.clear = true;
      HelpDisplay.clear = true;
      RestoreCursor.clear = true;
      LspKeymaps.clear = true;
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
