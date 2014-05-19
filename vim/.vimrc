set rtp+=~/.vim/
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
runtime! conf.d/*.vim
set completeopt=menu,preview
set nocompatible
filetype plugin indent on

"=====  Basic
set number
set showmode
set title
set ruler
set showcmd
set showmatch
set t_Co=256
set laststatus=2
set nobackup
set hidden
set vb t_vb=
set backspace=indent,eol,start
set autoread
"set whichwrap=b,s,h,l,<,>,[,]
set scrolloff=5

set nowritebackup
set nobackup
set noswapfile

syntax on
set smartindent 
set tabstop=4
set shiftwidth=4
set expandtab

"=== Encoding
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
"=== Search
set ignorecase
set smartcase 
set wrapscan
set noincsearch
set nohlsearch

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
augroup SkeletonAu
    autocmd!
    autocmd BufNewFile *.html 0r $HOME/.vim/skel.html
    autocmd BufNewFile *.pl 0r $HOME/.vim/skel.pl
    autocmd BufNewFile *.pm 0r $HOME/.vim/skel.pm
augroup END

autocmd FileType perl :map <C-n> <ESC>:!perl -cw %<CR>
autocmd FileType perl :map <C-e> <ESC>:!perl %<CR>
autocmd FileType ruby :map <C-n> <ESC>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>
"== netrw
let g:netrw_liststyle = 3
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
let g:netrw_altv = 1
let g:netrw_alto = 1
