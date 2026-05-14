{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.render-markdown-nvim
    ];

    extraConfigLua = ''
      require("render-markdown").setup({})
    '';

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
            theme = "auto";
            icons_enabled = true;
            globalstatus = true;
            component_separators = { left = "│"; right = "│"; };
            section_separators = { left = ""; right = ""; };
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostics" ];
            lualine_c = [ { __unkeyed-1 = "filename"; path = 1; } ];
            lualine_x = [
              {
                __unkeyed-1.__raw = ''
                  function()
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #clients == 0 then return "" end
                    local names = {}
                    for _, c in ipairs(clients) do table.insert(names, c.name) end
                    return table.concat(names, ",")
                  end
                '';
                icon = "";
              }
              "filetype"
              "encoding"
            ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
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
