{ pkgs, ... }:
{
  programs.nixvim = {
    # 起動時間短縮のため opt に置き、必要になった時点で packadd する
    extraPlugins = [
      { plugin = pkgs.vimPlugins.render-markdown-nvim; optional = true; }
      { plugin = pkgs.vimPlugins.nvim-hlslens; optional = true; }
    ];

    extraConfigLua = ''
      -- render-markdown は plugin/ 側が vim.g.render_markdown_config で setup し、
      -- packadd 時点のカレントバッファにも attach するので、設定を渡して packadd するだけでよい
      vim.g.render_markdown_config = { heading = { enabled = false } }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        once = true,
        callback = function()
          vim.cmd.packadd("render-markdown.nvim")
        end,
      })

      vim.api.nvim_create_autocmd("CmdlineEnter", {
        pattern = { "/", "?" },
        once = true,
        callback = function()
          vim.cmd.packadd("nvim-hlslens")
          require("hlslens").setup({})
        end,
      })
    '';

    plugins = {
      web-devicons.enable = true;

      gitsigns = {
        enable = true;
        settings.signcolumn = true;
      };

      todo-comments = {
        enable = true;
        settings.signs = false;
      };

      marks = {
        enable = true;
        settings = { };
      };

      treesitter-context = {
        enable = true;
        settings.max_lines = 5;
      };

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
