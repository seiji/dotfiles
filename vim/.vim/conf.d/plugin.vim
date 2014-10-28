
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
NeoBundle 'vim-scripts/repeat.vim'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'danro/rename.vim'
NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'slim-template/vim-slim'

if has("unix")
  if system('uname')=~'Darwin'
  else
    NeoBundle 'vim-scripts/fcitx.vim'
  endif
endif

call neobundle#end()
NeoBundleCheck

"===== unite
call unite#custom#source('file_rec/async', 'ignore_pattern', '\(png\|gif\|jpeg\|jpg\)$')
let g:unite_source_rec_max_cache_files = 5000

let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_source_history_yank_enable =1

" nmap <Space> [unite]
" nmap , [unite]
"
" nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=files buffer_tab file_mru directory_mru<CR>
" nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=files bookmark<CR>
" nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files jump_point file_point file file/new<CR>
" nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
" nnoremap <silent> [unite]d :<C-u>Unite -buffer-name=dirs directory directory/new<CR>
"
" nnoremap <silent> [unite]h :<C-u>Unite history/yank<CR>
" nnoremap <silent> [unite]o :<C-u>Unite file_rec/async:!<CR>
" nnoremap <silent> [unite]m :<C-u>Unite file_mru buffer<CR>
" nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"
" nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
" nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" nnoremap <silent> [unite]cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
"
" " CakePHP
" nnoremap <silent> [unite]jl  :<C-u>Unite file_rec/async:app/Logic/<CR>
" nnoremap <silent> [unite]jfl :<C-u>Unite file/new -input=app/Logic/<CR>
" nnoremap <silent> [unite]jt  :<C-u>Unite file_rec/async:app/Test/<C-R>
" nnoremap <silent> [unite]jft :<C-u>Unite file/new -input=app/Test/<C-R>

if executable('ag')
   let g:unite_source_grep_command = 'ag'
   let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
   let g:unite_source_grep_recursive_opt = ''
endif

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" endfunction"}}}

"===== vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = '^\%(.DS_Store\)$'
let g:vimfiler_safe_mode_by_default = 0
"let g:vimfiler_edit_action = 'tabopen'

"===== neocomplete
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_ignore_case = 1
" let g:neocomplete#enable_smart_case = 1
" if !exists('g:neocomplete#keyword_patterns')
"   let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns._ = '\h\w*'
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"===== lightline
let g:lightline = {
  \ 'colorscheme': 'wombat'
  \ }

"===== syntax
let g:syntastic_mode_map = { 'mode': 'passive',
 \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

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
\ 'exec': '%c run *.go',
\ }
let g:quickrun_config.swift = {
\ 'type': 'swift',
\ 'cmdopt': "-sdk `xcrun --show-sdk-path --sdk macosx`",
\ 'command': 'xcrun',
\ 'exec': '%c swift -i %s %o',
\ }

