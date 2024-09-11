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
      documentation = cmp.config.window.bordered({ max_width = 40 }),
    },
    formatting = {
      expandable_indicator = true,
      fields = { "kind", "abbr", "menu" },
      format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 20,
        ellipsis_char = '…',
        before = function(entry, vim_item)
          vim_item.abbr = vim_item.abbr:gsub('%b()', '(…)')
          vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, 20) .. "…"
          return vim_item
        end,
        symbol_map = { Copilot = "" },
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
end

return M
