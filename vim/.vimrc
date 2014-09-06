set rtp+=~/.vim/
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
runtime! conf.d/*.vim
set completeopt=menu
set nocompatible
filetype plugin indent on

" = FileType
let g:filetype_m = 'objc'

" 
function InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k\|<\|/'
    return "\<tab>"
  elseif exists('&omnifunc') && &omnifunc == ''
    return "\<c-n>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Languge Specification

" = Skelton
augroup TemplatesAu
  autocmd!
  autocmd BufNewFile *.rb 0r $HOME/.vim/templates/tpl.rb
  autocmd BufNewFile *.html 0r $HOME/.vim/templates/tpl.html
augroup END

autocmd FileType perl :map <C-n> <ESC>:!perl -cw %<CR>
autocmd FileType perl :map <C-e> <ESC>:!perl %<CR>
autocmd FileType ruby :map <C-n> <ESC>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>
