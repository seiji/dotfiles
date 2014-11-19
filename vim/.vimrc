set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Other plugins
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 't9md/vim-choosewin'
Plugin 'tomtom/tcomment_vim'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'

call vundle#end()               " required

filetype plugin indent on
"
" Settings
"
set autowrite
set autoread
set backspace=indent,eol,start
set confirm
set encoding=utf-8
set expandtab
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp
set fileformats=unix,dos,mac
set gdefault
set hidden
set hlsearch
set history=200
set incsearch
set ignorecase
set laststatus=2
set number
set nobackup
set noerrorbells
set noswapfile
set nowritebackup
set pastetoggle=<C-E>
set ruler
set scrolloff=8
set shiftwidth=2
set showcmd
set showmode
set smartcase
set smartindent
set softtabstop=2
set splitright
set splitbelow
set suffixesadd+=.rb
set tabstop=2
set title
set t_Co=256
set vb t_vb=
set wildmenu
set wildmode=full
set wrapscan

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

set noshowmatch
set nocursorcolumn
set lazyredraw

set ttyfast

set nocursorcolumn
set nocursorline
syntax sync minlines=256
set synmaxcol=128
set re=1

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

syntax enable

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
let mapleader = ","
let g:mapleader = ","

function! CloseSplitOrDeleteBuffer()
  let curNr = winnr()
  let curBuf = bufnr('%')
  wincmd w
  if winnr() == curNr
    exe 'bdelete'
  elseif curBuf != bufnr('%')
    wincmd W
    exe 'bdelete'
  else
    wincmd W
    wincmd c
  endif
endfunction

nnoremap <leader>q :call CloseSplitOrDeleteBuffer()<CR>

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
autocmd BufWritePre * :%s/\s\+$//e
autocmd InsertLeave * set nopaste

"===== Keymapping
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>
inoremap <C-[> <ESC>

" - buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" - split window
nnoremap <C-x>1 :only<CR>
nnoremap <C-x>2 :split<CR>
nnoremap <C-x>3 :vsplit<CR>
nnoremap <C-x>4 :close<CR>

" - comment
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" - highlight
nnoremap <silent> <C-L> :noh<C-L><CR>

"===== Filetype

" = Skelton
augroup TemplatesAu
  autocmd!
  autocmd BufNewFile *.rb 0r $HOME/.vim/templates/tpl.rb
  autocmd BufNewFile *.go 0r $HOME/.vim/templates/tpl.go
  autocmd BufNewFile *.html 0r $HOME/.vim/templates/tpl.html
augroup END

augroup filetypedetect
  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

" Golang
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Perl
autocmd FileType perl :map <C-n> <ESC>:!perl -cw %<CR>
autocmd FileType perl :map <C-e> <ESC>:!perl %<CR>
" Python
autocmd FileType python setl expandtab shiftwidth=4 softtabstop=4
" Ruby
autocmd FileType ruby :map <C-n> <ESC>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>
" JavaScript
autocmd Filetype javascript setl autoindent
autocmd FileType javascript setl smartindent cinwords=if,else,for,while,try,except,finally,def,class
autocmd FileType javascript setl expandtab tabstop=2 shiftwidth=2 softtabstop=0
" CSharp
autocmd FileType cs setl expandtab tabstop=4 shiftwidth=4 softtabstop=0
" ObjectiveC
let g:filetype_m = 'objc'

com! JSONFormat %!python -m json.tool

"===== Plugin

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

" go
let g:go_fmt_autosave = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"

" choosewin
nmap  -  <Plug>(choosewin)

" vim-airline
let g:airline_theme = 'badwolf'
let g:airline_left_sep  = ' '
let g:airline_right_sep = ' '

" nerdtree
let g:NERDTreeShowHidden=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMinimalUI=1

let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * execute 'NERDTree ./'
endif

function! g:NerdTreeFindToggle()
    if nerdtree#isTreeOpen()
        exec 'NERDTreeClose'
    else
        exec 'NERDTreeFind'
    endif
endfunction

noremap <Leader>n :<C-u>call g:NerdTreeFindToggle()<cr>
noremap <Leader>j :NERDTreeFind<cr>

let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"
"
noremap <Leader>l :TagbarToggle<CR>

" vim-go
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>t <Plug>(go-def-tab)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap  <leader>r  <Plug>(go-run)
au FileType go nmap  <leader>b  <Plug>(go-build)

au FileType go nmap <Leader>d <Plug>(go-doc)

"
function! InsertTabWrapper()
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

