{ pkgs, lib, ... }:
let
  nodeBin = "${pkgs.nodejs}/bin/node";
in
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.copilot-lua
      pkgs.vimPlugins.copilot-cmp
      pkgs.vimPlugins.copilot-lsp
    ];

    # copilot は node プロセスを起動するため、InsertEnter まで defer して起動時間を削減
    extraConfigLua = ''
      vim.api.nvim_create_autocmd("InsertEnter", {
        once = true,
        callback = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            copilot_node_command = "${nodeBin}",
          })
          require("copilot_cmp").setup()
        end,
      })
    '';

    plugins = {
      lazydev.enable = true;
      lspkind.enable = true;

      cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        completion.completeopt = "menu,menuone,noinsert";
        performance = {
          debounce = 60;
          throttle = 30;
          fetching_timeout = 500;
          max_view_entries = 30;
        };
        window = {
          completion.__raw = "require('cmp').config.window.bordered()";
          documentation.__raw = "require('cmp').config.disable";
        };
        formatting = {
          expandable_indicator = true;
          fields = [ "icon" "abbr" ];
          format = lib.mkForce { __raw = ''
            function(entry, vim_item)
              if entry.source.name == 'copilot' then
                vim_item.icon = ""
              end
              vim_item.abbr = vim_item.abbr:gsub('%b()', '(…)')
              return vim_item
            end
          ''; };
        };
        mapping.__raw = ''
          (function()
            local cmp = require('cmp')
            return cmp.mapping.preset.insert({
              ['<C-b>']     = cmp.mapping.scroll_docs(-4),
              ['<C-f>']     = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>']     = cmp.mapping.abort(),
              ['<CR>']      = cmp.mapping.confirm({ select = true }),
            })
          end)()
        '';
        # group_index による fallback: 1 のソースに候補がない時だけ 2 を使う
        sources = [
          { name = "nvim_lsp"; group_index = 1; }
          { name = "lazydev"; group_index = 1; }
          { name = "copilot"; group_index = 1; }
          { name = "buffer"; keyword_length = 2; group_index = 2; }
        ];
      };

      cmdline = {
        "/" = {
          mapping.__raw = "require('cmp').mapping.preset.cmdline()";
          sources = [ { name = "buffer"; } ];
        };
        "?" = {
          mapping.__raw = "require('cmp').mapping.preset.cmdline()";
          sources = [ { name = "buffer"; } ];
        };
        ":" = {
          completion.completeopt = "menu,menuone,noinsert,noselect";
          mapping.__raw = "require('cmp').mapping.preset.cmdline()";
          sources = [
            { name = "path"; }
            { name = "cmdline"; keyword_length = 2; }
          ];
          matching.disallow_symbol_nonprefix_matching = false;
        };
      };
    };
    };
  };
}
