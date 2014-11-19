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
"
call vundle#end()            " required

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" ==================== NerdTree ====================
" Open nerdtree in current dir, write our own custom function because
" NerdTreeToggle just sucks and doesn't work for buffers
function! g:NerdTreeFindToggle()
    if nerdtree#isTreeOpen()
        exec 'NERDTreeClose'
    else
        exec 'NERDTreeFind'
    endif
endfunction

" For toggling
noremap <Leader>n :<C-u>call g:NerdTreeFindToggle()<cr>

" For refreshing current file and showing current dir
noremap <Leader>j :NERDTreeFind<cr>

" ==================== vim-airline ====================
let g:airline_theme = 'molokai'

" NeoBundle 'Shougo/vimproc', {
"       \ 'build' : {
"       \     'windows' : 'make -f make_mingw32.mak',
"       \     'cygwin' : 'make -f make_cygwin.mak',
"       \     'mac' : 'make -f make_mac.mak',
"       \     'unix' : 'make -f make_unix.mak',
"       \    },
"       \ }
" NeoBundle 'vim-scripts/repeat.vim'
" NeoBundle 'vim-scripts/surround.vim'
" NeoBundle 'Shougo/vimshell'
" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/unite-outline'
" NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'Shougo/vimfiler'
" NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'dgryski/vim-godef'
" NeoBundle 'vim-jp/vim-go-extra'
" NeoBundle 'itchyny/lightline.vim'
"
" NeoBundle 'thinca/vim-quickrun'
" NeoBundle 'danro/rename.vim'
" " NeoBundle 'kchmck/vim-coffee-script'
" " NeoBundle 'toyamarinyon/vim-swift'
" " NeoBundle 'tomtom/tcomment_vim'
" " NeoBundle 'ekalinin/Dockerfile.vim'
" " NeoBundle 'plasticboy/vim-markdown'
" " NeoBundle 'tpope/vim-rails'
" " NeoBundle 'scrooloose/syntastic'
" " NeoBundle 'slim-template/vim-slim'
"
" if has("unix")
"   if system('uname')=~'Darwin'
"   else
"     NeoBundle 'vim-scripts/fcitx.vim'
"   endif
" endif
"

"===== quickrun
"set splitbelow
"set splitright
"let g:quickrun_config={'*': {'split': 'vertical'}}
autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
let g:quickrun_config={
\  "_" : {
\    "outputter/buffer/split" : ":botright 8sp",
\    "outputter/buffer/close_on_empty" : 1,
\    "runner" : "vimproc",
\    "runner/vimproc/updatetime" : 60,
\  },
\}
let g:quickrun_config['ruby.rspec'] = {
\ 'type': 'ruby.rspec',
\ 'command': 'rspec',
\ 'exec': 'bundle exec %c',
\ 'cmdopt': '-cfd'
\ }
let g:quickrun_config.rspecl = {
\ 'type': 'ruby.rspec',
\ 'command': 'rspec',
\ 'exec': 'bundle exec %c %s -l ' . line('.'),
\}
let g:quickrun_config.go = {
\ 'type': 'go',
\ 'command': 'go',
\ 'exec': '%c run *.go',
\ }
let g:quickrun_config.swift = {
\ 'type': 'swift',
\ 'cmdopt': "-sdk `xcrun --show-sdk-path --sdk macosx`",
\ 'command': 'xcrun',
\ 'exec': '%c swift -i %s %o',
\ }

