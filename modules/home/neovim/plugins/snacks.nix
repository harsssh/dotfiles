let
  mkRaw = body: { __raw = body; };
in
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        bigfile = { enabled = true; };
        quickfile = { enabled = true; };
        bufdelete = { enabled = true; };
        notifier = {
          enabled = true;
          timeout = 3000;
        };
        input = { enabled = true; };
        statuscolumn = { enabled = true; };
        indent = {
          enabled = true;
          indent.char = "▏";
          scope = {
            enabled = true;
            char = "▏";
          };
          animate.enabled = false;
        };
        words = { enabled = true; };
        rename = { enabled = true; };
        lazygit = { enabled = true; };
        picker = {
          enabled = true;
          ui_select = true;
          layout.preset = "vertical";
          sources.files.hidden = true;
          exclude = [
            ".git/"
            "node_modules/"
            "target/"
            "build/"
            "dist/"
            "*.lock"
            "*-lock.json"
            "*-lock.yaml"
            "*-lock.yml"
          ];
        };
        explorer = {
          enabled = true;
          replace_netrw = true;
        };
        picker.sources.explorer.layout.layout.position = "right";
      };
    };

    keymaps = [
      # Top Pickers & Explorer
      { mode = "n"; key = "<leader><space>"; action = mkRaw "function() Snacks.picker.smart() end"; options.desc = "Smart Find Files"; }
      { mode = "n"; key = "<leader>,"; action = mkRaw "function() Snacks.picker.buffers() end"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>/"; action = mkRaw "function() Snacks.picker.grep() end"; options.desc = "Grep"; }
      { mode = "n"; key = "<leader>e"; action = mkRaw "function() Snacks.explorer() end"; options.desc = "File Explorer"; }
      { mode = "n"; key = "-"; action = mkRaw "function() Snacks.explorer() end"; options.desc = "File Explorer"; }

      # Find
      { mode = "n"; key = "<leader>fb"; action = mkRaw "function() Snacks.picker.buffers() end"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>fc"; action = mkRaw ''function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end''; options.desc = "Find Config File"; }
      { mode = "n"; key = "<leader>ff"; action = mkRaw "function() Snacks.picker.files() end"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = mkRaw "function() Snacks.picker.git_files() end"; options.desc = "Find Git Files"; }
      { mode = "n"; key = "<leader>fr"; action = mkRaw "function() Snacks.picker.recent() end"; options.desc = "Recent"; }

      # Git
      { mode = "n"; key = "<leader>gl"; action = mkRaw "function() Snacks.picker.git_log() end"; options.desc = "Git Log"; }
      { mode = "n"; key = "<leader>gs"; action = mkRaw "function() Snacks.picker.git_status() end"; options.desc = "Git Status"; }
      { mode = "n"; key = "<leader>gd"; action = mkRaw "function() Snacks.picker.git_diff() end"; options.desc = "Git Diff (Hunks)"; }
      { mode = "n"; key = "<leader>gf"; action = mkRaw "function() Snacks.picker.git_log_file() end"; options.desc = "Git Log File"; }

      # Grep
      { mode = "n"; key = "<leader>sb"; action = mkRaw "function() Snacks.picker.lines() end"; options.desc = "Buffer Lines"; }
      { mode = "n"; key = "<leader>sB"; action = mkRaw "function() Snacks.picker.grep_buffers() end"; options.desc = "Grep Open Buffers"; }
      { mode = "n"; key = "<leader>sg"; action = mkRaw "function() Snacks.picker.grep() end"; options.desc = "Grep"; }

      # Search
      { mode = "n"; key = "<leader>sd"; action = mkRaw "function() Snacks.picker.diagnostics() end"; options.desc = "Diagnostics"; }
      { mode = "n"; key = "<leader>sD"; action = mkRaw "function() Snacks.picker.diagnostics_buffer() end"; options.desc = "Buffer Diagnostics"; }
      { mode = "n"; key = "<leader>sm"; action = mkRaw "function() Snacks.picker.marks() end"; options.desc = "Marks"; }
      { mode = "n"; key = "<leader>sq"; action = mkRaw "function() Snacks.picker.qflist() end"; options.desc = "Quickfix List"; }

      # LSP
      { mode = "n"; key = "gd"; action = mkRaw "function() Snacks.picker.lsp_definitions() end"; options.desc = "Goto Definition"; }
      { mode = "n"; key = "gD"; action = mkRaw "function() Snacks.picker.lsp_declarations() end"; options.desc = "Goto Declaration"; }
      { mode = "n"; key = "gr"; action = mkRaw "function() Snacks.picker.lsp_references() end"; options = { desc = "References"; nowait = true; }; }
      { mode = "n"; key = "gI"; action = mkRaw "function() Snacks.picker.lsp_implementations() end"; options.desc = "Goto Implementation"; }
      { mode = "n"; key = "gy"; action = mkRaw "function() Snacks.picker.lsp_type_definitions() end"; options.desc = "Goto Type Definition"; }
      { mode = "n"; key = "gai"; action = mkRaw "function() Snacks.picker.lsp_incoming_calls() end"; options.desc = "Calls Incoming"; }
      { mode = "n"; key = "gao"; action = mkRaw "function() Snacks.picker.lsp_outgoing_calls() end"; options.desc = "Calls Outgoing"; }
      { mode = "n"; key = "<leader>ss"; action = mkRaw "function() Snacks.picker.lsp_symbols() end"; options.desc = "LSP Symbols"; }
      { mode = "n"; key = "<leader>sS"; action = mkRaw "function() Snacks.picker.lsp_workspace_symbols() end"; options.desc = "LSP Workspace Symbols"; }

      # LazyGit
      { mode = "n"; key = "<leader>lg"; action = mkRaw "function() Snacks.lazygit() end"; options.desc = "LazyGit"; }

      # Bufdelete (mini.bufremove の置き換え)
      { mode = "n"; key = "<leader>bd"; action = mkRaw "function() Snacks.bufdelete() end"; options.desc = "Delete Buffer"; }
      { mode = "n"; key = "<leader>bo"; action = mkRaw "function() Snacks.bufdelete.other() end"; options.desc = "Delete Other Buffers"; }
      { mode = "n"; key = "<leader>ba"; action = mkRaw "function() Snacks.bufdelete.all() end"; options.desc = "Delete All Buffers"; }

      # Rename (LSP 連動のファイルリネーム)
      { mode = "n"; key = "R"; action = mkRaw "function() Snacks.rename.rename_file() end"; options.desc = "Rename File"; }

      # Words (LSP reference の前後ジャンプ)
      { mode = "n"; key = "]]"; action = mkRaw "function() Snacks.words.jump(vim.v.count1) end"; options.desc = "Next Reference"; }
      { mode = "n"; key = "[["; action = mkRaw "function() Snacks.words.jump(-vim.v.count1) end"; options.desc = "Prev Reference"; }
    ];
  };
}
