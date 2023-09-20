vim.cmd([[
let g:fern#renderer = "nerdfont"
let g:fern#default_hidden=1

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

function! s:fern_settings() abort
  setlocal nonumber
  nmap <silent> <buffer> dd <Plug>(fern-action-remove)
  nmap <buffer> q :<C-u>quit<CR>
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END
]])

local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-t>", "", {
  callback = function()
    if vim.bo.filetype == "fern" then
      vim.cmd.wincmd "p"
    else
      vim.cmd.Fern(".", "-reveal=%", "-drawer")
    end
  end,
  noremap = true,
  silent = true,
})
