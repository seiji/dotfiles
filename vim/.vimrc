"=====  Basic
set number
set showmode
set title
set ruler
set showcmd
set showmatch
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %l/%L\ (%P)%m%=%{strftime(\"%Y/%m/%d\ %H:%M\")} 
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

"===== Vundler
set nocompatible
filetype off                  

set rtp+=~/.vim/vundle.git/   
call vundle#rc()              

"===== Unite.vim
let g:unite_enable_start_insert=1
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR> 
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

au BufRead,BufNewFile *.mm            set filetype=objc

Bundle 'quickrun.vim'
" original repos on github
Bundle 'tpope/vim-fugitive'
" vim-scripts repos
"Bundle 'rails.vim'
Bundle 'tpope/vim-rails'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vinarise'

Bundle 'msanders/cocoa.vim'
Bundle 'gmarik/github-search.vim'


" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on 

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_snippets_dir='~/.vim/snippets'

" quickvim
let g:quickrun_config = { }
let g:quickrun_config["_"] = {
            \ "outputter/buffer/split" : ":rightbelow 8sp",
            \ "outputter/buffer/info" : 1,
            \ }
let g:quickrun_config['cs'] = {
			\ 'command': 'dmcs',
			\ 'exec': ['%c %o %s -out:%s:p:r.exe', 'mono %s:p:r.exe %a', 'rm -f %s:p:r.exe'],
			\ 'tempfile': '%{tempname(}.cs',
			\}
let g:quickrun_config['java'] = {
            \ 'command': 'javac',
            \ 'exec'   : ['%c %o %s', 'java %s:t:r %a', ':call delete("%S:t:r.class")'],
            \ 'tempfile': '%{tempname(}.java',
           \}
let g:quickrun_config["cpp"] = {
            \    "type"    : "cpp",
            \    "command" : "g++",
            \    "cmdopt"    : " -Wall",
            \}

" vimfiler
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0
autocmd FileType vimfiler nnoremap <buffer> / /\_^- \zs
