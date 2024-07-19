local M = {}

M.setup = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      expandable_indicator = true,
      fields = { "kind", "abbr", "menu" },
      format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 50,
        ellipsis_char = '…',
        before = function(entry, vim_item)
          local ELLIPSIS_CHAR = '…'
          local MAX_ABBR_LEN = 20
          local MAX_MENU_LEN = 20

          vim_item.abbr = vim_item.abbr:gsub('%b()', '(…)')

          local truncated_abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_LEN)
          local truncated_menu = vim.fn.strcharpart(vim_item.abbr, 0, MAX_MENU_LEN)
          if truncated_abbr ~= vim_item.abbr then
            vim_item.abbr = truncated_abbr .. ELLIPSIS_CHAR
          end
          if truncated_menu ~= vim_item.abbr then
            vim_item.menu = truncated_menu .. ELLIPSIS_CHAR
          end

          return vim_item
        end
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = "lazydev" },
      { name = "copilot" },
    }, {
      { name = 'buffer', keyword_length = 2 },
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline', keyword_length = 2 }
    }),
    matching = {
      disallow_symbol_nonprefix_matching = false,
    },
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local lspconfig = require('lspconfig')
  require('mason-lspconfig').setup_handlers {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
    end,
  }
end

return M
