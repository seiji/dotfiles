
"===== NeoBundle
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
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'ekalinin/Dockerfile.vim'

call neobundle#end()
NeoBundleCheck

"===== vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = '^\%(.DS_Store\)$'
let g:vimfiler_safe_mode_by_default = 0
"let g:vimfiler_edit_action = 'tabopen'

"===== neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"===== lightline
let g:lightline = {
  \ 'colorscheme': 'wombat'
  \ }

"===== quickrun
"set splitbelow
"set splitright
"let g:quickrun_config={'*': {'split': 'vertical'}}
let g:quickrun_config={
\  "_" : {
\    "outputter/buffer/split" : ":botright 8sp",
\    "outputter/buffer/close_on_empty" : 1,
\    "runner" : "vimproc",
\    "runner/vimproc/updatetime" : 60,
\  },
\}
let g:quickrun_config.go = {
\ 'type': 'go',
\ 'command': 'go',
\ 'exec': '%c run %s',
\ }
let g:quickrun_config.swift = {
\ 'type': 'swift',
\ 'cmdopt': "-sdk `xcrun --show-sdk-path --sdk macosx`",
\ 'command': 'xcrun',
\ 'exec': '%c swift -i %s %o', 
\ }

