local aug = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- terminal を開いたら insert mode に入る (行番号などは表示しない)
aug('MyTerminal', { clear = true })
autocmd('TermOpen', {
  group    = 'MyTerminal',
  pattern  = '*',
  callback = function()
    vim.cmd('startinsert')
    vim.opt_local.number         = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn     = 'no'
  end,
})

-- 外部から変更のあったファイルを自動リロード
aug('AutoReload', { clear = true })
autocmd({ 'WinEnter', 'FocusGained', 'BufEnter' }, {
  group   = 'AutoReload',
  pattern = '*',
  command = 'checktime',
})

-- Help 系で signcolumn を非表示
aug('HelpDisplay', { clear = true })
autocmd('FileType', {
  group    = 'HelpDisplay',
  pattern  = { 'help', 'man', 'qf', 'lspinfo', 'checkhealth' },
  callback = function()
    vim.opt_local.signcolumn = 'no'
  end,
})


-- カーソル位置保存
aug('RestoreCursor', { clear = true })
autocmd('BufReadPost', {
  group = 'RestoreCursor',
  pattern = '*',
  callback = function()
    local mark = vim.fn.line("'\"")
    if mark > 1 and mark <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- LSP アタッチ時のキーマップ
aug('LspKeymaps', { clear = true })
autocmd('LspAttach', {
  group = 'LspKeymaps',
  callback = function(args)
    local bufnr = args.buf
    local opts  = { buffer = bufnr, silent = true }
    local map   = vim.keymap.set
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'ge', vim.diagnostic.open_float, opts)
    map('n', 'g]', function()
      vim.diagnostic.jump({ count = 1, forward = true })
    end, opts)
    map('n', 'g[', function()
      vim.diagnostic.jump({ count = 1, forward = false })
    end, opts)
    map('n', 'gf', vim.lsp.buf.format, opts)
    map('n', 'gn', vim.lsp.buf.rename, opts)
    map('n', 'ga', vim.lsp.buf.code_action, opts)
  end,
})
