-- terminal を開いたら insert mode に入る。行番号などは表示しない。
-- command, callback は一度に設定できないので分ける
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end
})


-- help などで余計な column を表示させない
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
  callback = function()
    vim.opt_local.signcolumn = "no"
  end,
})

-- 外部からファイルを変更されたら反映する
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})

-- カーソル位置を保存
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'g]', function()
      vim.diagnostic.jump({ count = 1, forward = true })
    end, opts)
    vim.keymap.set('n', 'g[', function()
      vim.diagnostic.jump({ count = 1, forward = false })
    end, opts)
    vim.keymap.set('n', 'gf', vim.lsp.buf.format, opts)
    vim.keymap.set('n', 'gn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  end
})
