let
  mkRaw = body: { __raw = body; };
in
{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        folding.enable = true;
        settings = {
          auto_install = true;
          sync_install = false;
          ensure_installed = [
            "c"
            "cpp"
            "go"
            "rust"
            "haskell"
            "scala"
            "lua"
            "typescript"
            "javascript"
            "ruby"
            "markdown"
            "markdown_inline"
          ];
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent = {
            enable = true;
            disable = [ "ruby" ];
          };
        };
      };

      hop = {
        enable = true;
        settings.keys = "etovxqpdygfblzhckisuran";
      };

      ts-autotag.enable = true;

      mini = {
        enable = true;
        modules = {
          bracketed = { };
          comment = { };
          pairs = { };
          surround.mappings.highlight = "";
          cursorword = { };
          tabline.tabpage_section = "right";
          trailspace = { };
        };
      };
    };

    keymaps = [
      {
        mode = "";
        key = "f";
        action = mkRaw ''
          function()
            require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })
          end
        '';
      }
      {
        mode = "";
        key = "F";
        action = mkRaw ''
          function()
            require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })
          end
        '';
      }
      {
        mode = "";
        key = "t";
        action = mkRaw ''
          function()
            require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
          end
        '';
      }
      {
        mode = "";
        key = "T";
        action = mkRaw ''
          function()
            require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
          end
        '';
      }
      # mini.bracketed
      { mode = "n"; key = "<leader>l"; action = "<Cmd>lua MiniBracketed.buffer('forward')<CR>"; }
      { mode = "n"; key = "<leader>h"; action = "<Cmd>lua MiniBracketed.buffer('backward')<CR>"; }
    ];

    extraConfigLuaPost = ''
      -- mini.cursorword の色
      vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })
    '';
  };
}
