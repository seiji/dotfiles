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

"=== KeyBind
noremap ; :
noremap : ;

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>

""noremap <C-j> <C-f>
""noremap <C-k> <C-b>

""inoremap { {}<LEFT>
""inoremap [ []<LEFT>
""inoremap ( ()<LEFT>
""inoremap " ""<LEFT>
""inoremap ' ''<LEFT>
""vnoremap { "zdi{<C-R>z}<ESC>
""vnoremap [ "zdi[<C-R>z]<ESC>
""vnoremap ( "zdi(<C-R>z)<ESC>
""vnoremap " "zdi"<C-R>z"<ESC>
""vnoremap ' "zdi'<C-R>z'<ESC>

" - split window 
nnoremap <C-x>1 :only<CR>
nnoremap <C-x>2 :split<CR>
nnoremap <C-x>3 :vsplit<CR>
nnoremap <C-x>4 :close<CR>

nmap sj <C-W>j<C-w>
nmap sk <C-W>k<C-w>
nmap sh <C-w>h<C-w>
nmap sl <C-w>l<C-w>
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

"===== NeoBundle
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'itchyny/lightline.vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"===== lightline
let g:lightline = {
  \ 'colorscheme': 'wombat'
  \ }