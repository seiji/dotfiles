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
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"=== Encoding
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
