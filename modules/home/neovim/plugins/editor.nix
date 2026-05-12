let
  mkRaw = body: { __raw = body; };
in
{
  programs.nixvim = {
    plugins = {
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
          bufremove = { };
          trailspace = { };
          indentscope = {
            symbol = "▏";
            draw.animation.__raw = "require('mini.indentscope').gen_animation.none()";
          };
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
      # mini.bufremove
      { mode = "n"; key = "<leader>bd"; action = "<Cmd>lua MiniBufremove.delete()<CR>"; }
      {
        mode = "n";
        key = "<leader>bo";
        action = mkRaw ''
          function()
            local cur = vim.api.nvim_get_current_buf()
            local deleted_count = 0
            local bufs = vim.api.nvim_list_bufs()
            for _, buf in ipairs(bufs) do
              if buf ~= cur
                 and vim.api.nvim_buf_is_valid(buf)
                 and vim.bo[buf].buflisted then
                local ok = pcall(require("mini.bufremove").delete, buf, false)
                if ok then
                  deleted_count = deleted_count + 1
                end
              end
            end
            if deleted_count > 0 then
              vim.notify(string.format("Deleted %d buffer(s)", deleted_count))
            end
          end
        '';
      }
    ];

    extraConfigLuaPost = ''
      -- mini.cursorword の色
      vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })
    '';
  };
}
