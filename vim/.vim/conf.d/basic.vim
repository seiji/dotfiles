"=====  Basic
" display
set number
set laststatus=2
set showcmd
set showmatch
set showmode
set title
set ruler
" cursor
set backspace=indent,eol,start
set scrolloff=8
" file
set confirm
set hidden
set autoread
set nobackup
set nowritebackup
set noswapfile
" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault
" indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
" color
set t_Co=256
set vb t_vb=

" exmode
set wildmenu
set wildmode=full
set history=200
set pastetoggle=<C-E>

syntax on

" encoding
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
autocmd BufWritePre * :%s/\s\+$//e
autocmd InsertLeave * set nopaste
