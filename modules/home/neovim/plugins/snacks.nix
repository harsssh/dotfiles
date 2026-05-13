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
            animate.enabled = false;
          };
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
      };
    };

    keymaps = [
      # Picker
      { mode = "n"; key = "<leader>ff"; action = mkRaw "function() Snacks.picker.files() end"; options.desc = "Picker: Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = mkRaw "function() Snacks.picker.grep() end"; options.desc = "Picker: Live Grep"; }
      { mode = "n"; key = "<leader>fb"; action = mkRaw "function() Snacks.picker.lines() end"; options.desc = "Picker: Buffer Lines"; }
      { mode = "n"; key = "<leader>fe"; action = mkRaw "function() Snacks.picker.recent() end"; options.desc = "Picker: Recent Files"; }
      { mode = "n"; key = "<leader>fB"; action = mkRaw "function() Snacks.picker.buffers() end"; options.desc = "Picker: Buffers"; }
      { mode = "n"; key = "<leader>gs"; action = mkRaw "function() Snacks.picker.git_status() end"; options.desc = "Picker: Git Status"; }
      {
        mode = "n";
        key = "<leader>fs";
        action = mkRaw ''
          function()
            Snacks.picker.lsp_workspace_symbols({
              filter = { default = { "Class", "Function", "Method", "Interface", "Struct", "Module", "Constant", "Enum" } },
            })
          end
        '';
        options.desc = "Picker: Workspace Symbols";
      }

      # Explorer (fern の `-` を置き換え)
      { mode = "n"; key = "-"; action = mkRaw "function() Snacks.explorer() end"; options.desc = "Explorer"; }

      # LazyGit
      { mode = "n"; key = "<leader>lg"; action = mkRaw "function() Snacks.lazygit() end"; options.desc = "LazyGit"; }

      # Bufdelete (mini.bufremove の置き換え)
      { mode = "n"; key = "<leader>bd"; action = mkRaw "function() Snacks.bufdelete() end"; options.desc = "Delete Buffer"; }
      { mode = "n"; key = "<leader>bo"; action = mkRaw "function() Snacks.bufdelete.other() end"; options.desc = "Delete Other Buffers"; }

      # Rename (LSP 連動のファイルリネーム)
      { mode = "n"; key = "<leader>rf"; action = mkRaw "function() Snacks.rename.rename_file() end"; options.desc = "Rename File"; }

      # Words (LSP reference の前後ジャンプ)
      { mode = "n"; key = "]]"; action = mkRaw "function() Snacks.words.jump(vim.v.count1) end"; options.desc = "Next Reference"; }
      { mode = "n"; key = "[["; action = mkRaw "function() Snacks.words.jump(-vim.v.count1) end"; options.desc = "Prev Reference"; }
    ];
  };
}
