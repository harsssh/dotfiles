{
  programs.nixvim = {
    plugins = {
      web-devicons.enable = true;

      gitsigns = {
        enable = true;
        settings.signcolumn = true;
      };

      hlslens = {
        enable = true;
        settings = { };
      };

      fidget = {
        enable = true;
        settings.notification.override_vim_notify = true;
      };

      todo-comments = {
        enable = true;
        settings.signs = false;
      };

      marks = {
        enable = true;
        settings = { };
      };

      treesitter-context.enable = true;

      lualine = {
        enable = true;
        settings = {
          options = {
            component_separators = "";
            section_separators = "";
            globalstatus = true;
            theme = {
              normal.c = { fg = "#bbc2cf"; bg = "#202328"; };
              inactive.c = { fg = "#bbc2cf"; bg = "#202328"; };
            };
          };
          sections = {
            lualine_a = [ ];
            lualine_b = [ ];
            lualine_y = [ ];
            lualine_z = [ ];
            lualine_c = [
              {
                __unkeyed-1.__raw = "function() return '▊' end";
                color = { fg = "#51afef"; };
                padding = { left = 0; right = 1; };
              }
              {
                __unkeyed-1.__raw = "function() return '' end";
                color.__raw = ''
                  function()
                    local colors = {
                      bg = '#202328', fg = '#bbc2cf', yellow = '#ECBE7B', cyan = '#008080',
                      darkblue = '#081633', green = '#98be65', orange = '#FF8800',
                      violet = '#a9a1e1', magenta = '#c678dd', blue = '#51afef', red = '#ec5f67',
                    }
                    local mode_color = {
                      n = colors.red, i = colors.green, v = colors.blue,
                      ['\22'] = colors.blue, V = colors.blue, c = colors.magenta,
                      no = colors.red, s = colors.orange, S = colors.orange,
                      ['\19'] = colors.orange, ic = colors.yellow, R = colors.violet,
                      Rv = colors.violet, cv = colors.red, ce = colors.red,
                      r = colors.cyan, rm = colors.cyan, ['r?'] = colors.cyan,
                      ['!'] = colors.red, t = colors.red,
                    }
                    return { fg = mode_color[vim.fn.mode()] }
                  end
                '';
                padding = { right = 1; };
              }
              {
                __unkeyed-1 = "filesize";
                cond.__raw = "function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end";
              }
              {
                __unkeyed-1 = "filename";
                cond.__raw = "function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end";
                color = { fg = "#c678dd"; gui = "bold"; };
              }
              { __unkeyed-1 = "location"; }
              { __unkeyed-1 = "progress"; color = { fg = "#bbc2cf"; gui = "bold"; }; }
              {
                __unkeyed-1 = "diagnostics";
                sources = [ "nvim_diagnostic" ];
                symbols = { error = " "; warn = " "; info = " "; };
                diagnostics_color = {
                  error.fg = "#ec5f67";
                  warn.fg = "#ECBE7B";
                  info.fg = "#008080";
                };
              }
              { __unkeyed-1.__raw = "function() return '%=' end"; }
              {
                __unkeyed-1.__raw = ''
                  function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_clients()
                    if next(clients) == nil then
                      return msg
                    end
                    for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                      end
                    end
                    return msg
                  end
                '';
                icon = " LSP:";
                color = { fg = "#ffffff"; gui = "bold"; };
              }
            ];
            lualine_x = [
              {
                __unkeyed-1 = "o:encoding";
                fmt.__raw = "string.upper";
                cond.__raw = "function() return vim.fn.winwidth(0) > 80 end";
                color = { fg = "#98be65"; gui = "bold"; };
              }
              {
                __unkeyed-1 = "fileformat";
                fmt.__raw = "string.upper";
                icons_enabled = false;
                color = { fg = "#98be65"; gui = "bold"; };
              }
              {
                __unkeyed-1 = "branch";
                icon = "";
                color = { fg = "#a9a1e1"; gui = "bold"; };
              }
              {
                __unkeyed-1 = "diff";
                symbols = { added = " "; modified = "󰝤 "; removed = " "; };
                diff_color = {
                  added.fg = "#98be65";
                  modified.fg = "#FF8800";
                  removed.fg = "#ec5f67";
                };
                cond.__raw = "function() return vim.fn.winwidth(0) > 80 end";
              }
              {
                __unkeyed-1.__raw = "function() return '▊' end";
                color.fg = "#51afef";
                padding.left = 1;
              }
            ];
          };
          inactive_sections = {
            lualine_a = [ ];
            lualine_b = [ ];
            lualine_y = [ ];
            lualine_z = [ ];
            lualine_c = [ ];
            lualine_x = [ ];
          };
        };
      };
    };

    extraConfigLuaPost = ''
      -- treesitter-context のハイライト
      vim.cmd([[ hi TreesitterContextBottom gui=underline guisp=Grey ]])
      vim.cmd([[ hi TreesitterContextLineNumberBottom gui=underline guisp=Grey ]])
    '';
  };
}
