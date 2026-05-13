{ pkgs, lib, ... }:
{
  programs.nixvim.plugins = {
    lazydev.enable = true;
    lspkind.enable = true;

    copilot-lua = {
      enable = true;
      settings = {
        suggestion.enabled = false;
        panel.enabled = false;
        copilot_node_command = "${pkgs.nodejs}/bin/node";
      };
    };

    copilot-cmp.enable = true;

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
          fields = [ "kind" "abbr" ];
          format = lib.mkForce { __raw = ''
            require('lspkind').cmp_format({
              mode = 'symbol',
              maxwidth = 50,
              ellipsis_char = '…',
              before = function(entry, vim_item)
                vim_item.abbr = vim_item.abbr:gsub('%b()', '(…)')
                if vim_item.menu then
                  vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, 50) .. "…"
                end
                return vim_item
              end,
              symbol_map = { Copilot = "" },
            })
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
}
