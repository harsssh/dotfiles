-- 文字コード
vim.opt.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- 変数
vim.g.mapleader = '-'

-- バックアップ
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.hidden = true -- バッファが編集中でも他のファイルを開けるように

-- 表示
vim.opt.showcmd = true -- 入力中のコマンドを表示
vim.opt.number = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.wrap = true
vim.opt.title = true
vim.opt.showtabline = 2
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- 行数表示の横に余白
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.winblend = 5 -- float-transparent
--vim.opt.ambiwidth = 'double'

-- インデント
-- ファイルタイプごとのインデント設定を行う関数
local function set_indent_settings(filetype, use_tabs, indent_width)
    if use_tabs then
        vim.cmd(string.format("autocmd FileType %s setlocal noexpandtab", filetype))
        vim.cmd(string.format("autocmd FileType %s setlocal tabstop=%d", filetype, indent_width))
        vim.cmd(string.format("autocmd FileType %s setlocal shiftwidth=%d", filetype, indent_width))
        vim.cmd(string.format("autocmd FileType %s setlocal softtabstop=%d", filetype, indent_width))
    else
        vim.cmd(string.format("autocmd FileType %s setlocal expandtab", filetype))
        vim.cmd(string.format("autocmd FileType %s setlocal shiftwidth=%d", filetype, indent_width))
        vim.cmd(string.format("autocmd FileType %s setlocal tabstop=%d", filetype, indent_width))
        vim.cmd(string.format("autocmd FileType %s setlocal softtabstop=%d", filetype, indent_width))
    end
end


set_indent_settings('c', true, 4)
set_indent_settings('typescriptreact', false, 2)

vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- smartindentの幅
vim.opt.tabstop = 4 -- タブ文字の幅
vim.opt.softtabstop = 4
vim.opt.autoindent = true -- 改行時のインデント継続
vim.opt.smartindent = true -- 改行時のインデントをいい感じに
vim.opt.breakindent = true
vim.opt.smarttab = true
vim.opt.list = true
vim.opt.listchars = {
	--tab='▸-',
	tab='  ',
	trail='-',
	space='⋅',
	extends='›',
	precedes='‹',
	nbsp='%',
} -- 不可視文字の表示

-- 文字列検索
vim.opt.incsearch = true -- 文字入力毎に検索
vim.opt.ignorecase = true -- 大文字小文字を区別しない
vim.opt.smartcase = true -- 大文字を含んでいる場合は区別する
vim.opt.hlsearch = true -- 検索結果をハイライト
vim.opt.scrolloff = 10

-- ベル
vim.opt.visualbell = false
vim.opt.belloff = 'all'

-- キー入力
vim.opt.virtualedit = 'all'
vim.opt.backspace = 'indent,eol,start'
vim.opt.showmatch = true

-- マウス操作
vim.opt.mouse = 'a'

-- util
vim.opt.inccommand = 'split'
vim.opt.autoread = true
vim.opt.clipboard = 'unnamed' -- クリップボードとレジスタを共有
vim.opt.wildmenu = true -- コマンドの補完

-- Timings
vim.opt.updatetime = 300

