set nocompatible              " be iMproved, required
filetype off                  " required
set list listchars=tab:»\ ,

let g:loaded_2html_plugin      = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

set rtp+=~/.vim/plugged/vim-plug
set tags+=tags
call plug#begin('~/.vim/plugged')

" Other plugins
Plug 'Shougo/vimproc.vim'
" Plug 'tpope/vim-dispatch'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'

Plug 'janko-m/vim-test'
Plug 'craigemery/vim-autotag'
Plug 'thinca/vim-quickrun'

" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/async.vim'

Plug 'majutsushi/tagbar'
Plug 'tpope/vim-eunuch'
Plug 'editorconfig/editorconfig-vim'

" Plug 'ervandew/supertab'
" Plug 'Valloric/YouCompleteMe'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/surround.vim'

" " language
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
" Plug 'arnaud-lb/vim-php-namespace'
" Plug 'OmniSharp/omnisharp-vim'
Plug 'derekwyatt/vim-scala'
Plug 'fatih/vim-go'
Plug 'posva/vim-vue'
Plug 'hashivim/vim-terraform'
Plug 'chr4/nginx.vim'
Plug 'isRuslan/vim-es6'
" Plug 'myhere/vim-nodejs-complete'
" Plug 'keith/swift.vim'
"
"
" """"""""
Plug 'tpope/vim-fugitive'

call plug#end()

filetype plugin indent on
"
" Settings
"
set autoread
set autowrite
set backspace=indent,eol,start
set confirm
set encoding=utf-8
set expandtab
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp
set fileformats=unix,dos,mac
set gdefault
set hidden
set hlsearch
hi Search ctermbg=Cyan
hi Search ctermfg=White
set history=200
set incsearch
set ignorecase

set laststatus=2

set number
set nobackup
set noerrorbells
set noshowmode
set noswapfile
set nowritebackup
set pastetoggle=<C-E>
set ruler
set scrolloff=8
set shiftwidth=2
set showcmd
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

" imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
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

function! s:ChangeCurrentDirectory()
  let l:dir = expand("%:p:h")
  if isdirectory(fnamemodify(l:dir, ":p"))
    execute printf('lcd `=%s`', string(fnamemodify(l:dir, ":p")))
  endif
endfunction

autocmd BufEnter * call s:ChangeCurrentDirectory()
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
autocmd BufWritePre * :%s/\s\+$//e
autocmd InsertLeave * set nopaste

"===== Keymapping
nmap ; :Buffers
nmap t :Files
" nmap r :Tags
nmap f :Rg<Space>
nnoremap <silent> <leader>v :Dirvish<CR>
nnoremap <silent> <leader>q :call CloseSplitOrDeleteBuffer()<CR>

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>
inoremap <C-[> <ESC>

" nnoremap <silent> <leader>f :GFiles<CR>
" nnoremap <silent> <leader>F :GFiles?<CR>
" nnoremap <silent> <leader>b :Buffers<CR>
" nnoremap <silent> <leader>l :BLines<CR>
" nnoremap <silent> <leader>h :History<CR>
" nnoremap <silent> <leader>m :Mark<CR>
nnoremap <silent> <C-p> :FZFFileList<CR>
nnoremap <silent> <C-x><C-f> :FZFCd<CR>

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


let s:ignore_patterns = [
    \ '__pycache__/',
    \ '__pycache__',
    \ '\.bundle',
    \ '\.facts',
    \ '\.git',
    \ '*\.min\.js',
    \ '*\.pyc',
    \ '*\.sqlite3',
    \ '*\.swp',
    \ '*\.csproj',
    \ '*\.sln',
    \ '*\.unityproj',
    \ '*\.userprefs',
    \ '\.sass-cache',
    \ ]

call add(s:ignore_patterns, '*\.o') " langc
call add(s:ignore_patterns, '*\.meta') " Unity
call add(s:ignore_patterns, 'tags') " ctags

set wildignore+=\.hg,\.git,\.svn                    " Version control
set wildignore+=*\.aux,*\.out,*\.toc                " LaTeX intermediate files
set wildignore+=*\.jpg,*\.bmp,*\.gif,*\.png,*\.jpeg   " binary images
set wildignore+=*\.o,*\.obj,*\.exe,*\.dll,*\.manifest " compiled object files
set wildignore+=*\.spl                            " compiled spelling word lists
set wildignore+=*\.sw?                            " Vim swap files
set wildignore+=*\.DS_Store                       " OSX bullshit
set wildignore+=*\.luac                           " Lua byte code
set wildignore+=*\.vagrant                        " Vagrant
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*\.pyc                            " Python byte code
set wildignore+=*/tmp/*,*\.so,*\.swp,*\.zip         " MacOSX/Linux
set wildignore+=*\\tmp\\*,*\.swp,*\.zip,*\.exe      " Windows
"===== Filetype

function! NewJavaFile()
  silent! 0r $HOME/.vim/templates/tpl.java
  %s/FILENAME/\=expand("%:t:r")
endfunction

" = Skelton
augroup TemplatesAu
  autocmd!
  autocmd BufNewFile *.c       0r $HOME/.vim/templates/tpl.c
  autocmd BufNewFile *.cpp     0r $HOME/.vim/templates/tpl.cpp
  autocmd BufNewFile *.cs      0r $HOME/.vim/templates/tpl.cs
  autocmd BufNewFile *.go      0r $HOME/.vim/templates/tpl.go
  autocmd BufNewFile *.html    0r $HOME/.vim/templates/tpl.html
  autocmd BufNewFile *.java    call NewJavaFile()
  autocmd BufNewFile *.proto   0r $HOME/.vim/templates/tpl.proto
  autocmd BufNewFile *.py      0r $HOME/.vim/templates/tpl.py
  autocmd BufNewFile *.rb      0r $HOME/.vim/templates/tpl.rb
  autocmd BufNewFile *.service 0r $HOME/.vim/templates/tpl.service
  autocmd BufNewFile Makefile  0r $HOME/.vim/templates/tpl.Makefile
  autocmd BufNewFile README.md 0r $HOME/.vim/templates/tpl.README.md
  autocmd BufNewFile docker-compose.* 0r $HOME/.vim/templates/tpl.docker-compose.yml
augroup END

augroup FileTypeDetect
  autocmd!
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf*  setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *.go,go.mod setlocal noet tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *.go.testing setlocal noet tabstop=4 shiftwidth=4 softtabstop=4
  " autocmd BufWritePre *.go GoFmt
  autocmd BufNewFile,BufRead *_test.go setlocal filetype=go.testing tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *Test.php setlocal filetype=php.phpunit
  autocmd BufNewFile,BufRead *_spec.rb set filetype=ruby.rspec
  autocmd BufNewFile,BufRead *.coffee setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType javascript setlocal smartindent cinwords=if,else,for,while,try,except,finally,def,class
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType cs setlocal  tabstop=4 shiftwidth=4 softtabstop=4
  " autocmd BufWritePre *.cs OmniSharpCodeFormat
  autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead Dockerfile*  setf dockerfile
  autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType make setlocal noexpandtab
augroup END

" ObjectiveC
let g:filetype_m = 'objc'

" Wildmenu completion {{{
set wildmenu
" set wildmode=list:longest
set wildmode=list:full

let &wildignore=join(s:ignore_patterns, ',')

com! JSONFormat %!python -m json.tool

"===== Plugin
" dirvish
augroup dirvish_commands
  autocmd!

  autocmd FileType dirvish nnoremap <silent> <buffer> <C-r> :<C-u>Dirvish %<CR>
  autocmd FileType dirvish unmap <silent> <buffer> <CR>
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish nnoremap <silent> <buffer> <CR> :<C-u> call <SID>dirvish_open()<CR>
  autocmd FileType dirvish setlocal nonumber norelativenumber statusline=%F
  autocmd FileType dirvish nnoremap <buffer><silent> <C-j> <C-\><C-n>j:call feedkeys("p")<CR>
  autocmd FileType dirvish nnoremap <buffer><silent> <C-k> <C-\><C-n>k:call feedkeys("p")<CR>
  "autocmd FileType dirvish silent! keeppatterns g@\v/\.[^\/]+/?$@d

  " au User DirvishEnter let b:dirvish.showhidden = 1
  for pat in s:ignore_patterns
    autocmd FileType dirvish silent! keeppatterns g@\v/\.pat./?$@d
  endfor
augroup END

" YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_filetype_blacklist = { 'ruby' : 1 }

let g:SuperTabDefaultCompletionType = '<C-n>'

" choosewin
nmap  -  <Plug>(choosewin)

noremap <Leader>l :TagbarToggle<CR>

" snippets
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res == 0
    if pumvisible()
      return "\<C-N>"
    else
      return "\<TAB>"
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif
  return ""
endfunction

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:UltiSnipsExpandTrigger = "<tab>"

if !exists("g:UltiSnipsJumpForwardTrigger")
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

function! FilePath()
  if winwidth(0) > 90
    return expand("%:s")
  else
    return expand("%:t")
  endif
endfunction

let g:lightline = {
\   'colorscheme': 'powerline',
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'readonly', 'filename', 'modified', ] ]
\   },
\   'component_function':{
\     'filename': 'FilePath'
\   },
\ }

" w0rp/ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
  \ 'php': ['phpcs', 'php'],
  \ 'terraform': ['fmt']
\}
let g:ale_php_phpcs_standard = 'PSR1,PSR2'
let g:autotagTagsFile=".tags"

""" phpcd
let g:phpcd_autoload_path = 'vendor/autoload.php'

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" vim-go
augroup go_commands
  autocmd!
  au FileType go nmap <Leader>d <Plug>(go-def)
  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  au FileType go nmap <Leader>im  <Plug>(go-import)
  au FileType go nmap <Leader>ims <Plug>(go-imports)
  au FileType go nmap <Leader>mt :GoFmt<CR>
  au FileType go.testing nmap <Leader>im  <Plug>(go-import)
  au FileType go.testing nmap <Leader>ims <Plug>(go-imports)
  au FileType go.testing nmap <Leader>mt :GoFmt<CR>

  au FileType go nmap <Leader>if <Plug>(go-info)

  " au FileType go nmap <Leader>r <Plug>(go-run)
  au FileType go nmap <Leader>b <Plug>(go-build)

  au FileType go nmap <Leader>d <Plug>(go-doc)
augroup END

" let g:go_fmt_command = "goimports" " Enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "gofmt"
let g:go_fmt_autosave = 0 " Enable auto fmt on save
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_template_autocreate = 0

let g:terraform_fmt_on_save=0

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


" nmap <silent> t<C-n> :TestNearest<CR>
" nmap <silent> <Leader>r :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
" nmap <silent> t<C-g> :TestVisit<CR>
" let test#strategy = "dispatch"
" let g:test#preserve_screen = 1

"===== qmuickrun
""set splitbelow
"set splitright
""let g:quickrun_config={'*': {'split': 'vertical'}}

let g:quickrun_config = {'_': {}}
let g:quickrun_config._.input = '=@i'
let g:quickrun_config._.input = '=%{b:input}'

let g:quickrun_config = {
  \  "_" : {
  \    "runner" : "vimproc",
  \    "runner/vimproc/updatetime" : 60,
  \    'hook/close_quickfix/enable_hook_loaded' : 1,
  \    'hook/close_quickfix/enable_success' : 1,
  \    'hook/close_buffer/enable_failure': 1,
  \    'outputter' : 'error',
  \    'outputter/error/success' : 'buffer',
  \    'outputter/error/error'   : 'quickfix',
  \    'outputter/buffer/split'  : ':rightbelow 8sp',
  \    'outputter/buffer/close_on_empty' : 1,
  \  },
  \  "make" : {
  \    "command" : "make %o",
  \    "exec" : "%c",
  \    "runner" : "vimproc",
  \   },
  \}
let g:quickrun_config.cpp = {
  \ 'cmdopt' : '-std=c++1y -Wall -Wextra -O2',
  \ 'command': 'clang++',
  \ 'exec' : ['%c %o %s -o %s:p:r', '%s:p:r %a'],
  \ }
let g:quickrun_config.matlab = {
  \ 'cmdopt' : '',
  \ 'command': 'octave-cli',
  \ 'exec' : '%c %o %s',
  \ }

let g:quickrun_config['php.phpunit'] = {
  \ 'hook/cd/directory'              : '%S:p:h',
  \ 'command'                        : './vendor/bin/phpunit',
  \ 'cmdopt'                         : '',
  \ 'exec'                           : '%c %o %s',
  \ 'outputter/quickfix/errorformat' : '%f:%l,%m in %f on line %l',
  \}

let g:quickrun_config['ruby.rspec'] = {
  \ 'type': 'ruby.rspec',
  \ 'cmdopt': '-cfd',
  \ 'command': 'rspec',
  \ 'exec': 'bundle exec %c %o',
  \ }
let g:quickrun_config.rspecl = {
  \ 'type': 'ruby.rspec',
  \ 'command': 'rspec',
  \ 'exec': 'bundle exec %c %s -l ' . line('.'),
  \}
" let g:quickrun_config.go = {
"       \ 'type': 'go',
"       \ 'command': 'go',
"       \ 'exec': 'go run *.go',
"       \ }
let g:quickrun_config['go.testing'] = {
  \ 'type': 'go',
  \ 'command': 'go',
  \ 'exec': '%c test -v *.go',
  \ }
let g:quickrun_config.swift = {
  \ 'type': 'swift',
  \ 'cmdopt': "-sdk `xcrun --show-sdk-path --sdk macosx`",
  \ 'command': 'xcrun',
  \ 'exec': '%c swift %s %o',
  \ }

"""
command! FZFCd call fzf#run({
  \ 'down': '50%',
  \ 'source': 'find . -type d -maxdepth 5',
  \ 'sink': 'e'})
command! FZFFileList call fzf#run({
  \ 'down': '50%',
  \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
  \ 'sink': 'e'})
command! -bang -nargs=* Ripgrep
  \ call fzf#vim#grep(
	\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
	\   <bang>0 ? fzf#vim#with_preview('up:60%')
	\           : fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
	\   <bang>0)

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

