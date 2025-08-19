syntax on

colorscheme habamax

inoremap jj <ESC>
nmap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap ss :split<CR>
nnoremap sv :vsp<CR>

set incsearch
set ignorecase
set smartcase
set hlsearch
set clipboard+=unnamed
set showcmd
set virtualedit=all

" vimdiff で役に立つ
set diffopt+=algorithm:patience,indent-heuristic
