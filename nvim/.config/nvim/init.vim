let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

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

"========================================="
" plugins
"========================================="
if &compatible
 set nocompatible
endif
filetype off

if empty( glob($CONFIG . '/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

set rtp+=~/.config/nvim/plugged/vim-plug

set tags+=tags
call plug#begin($CONFIG . '/nvim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'itchyny/lightline.vim'
  Plug 'justinmk/vim-dirvish'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'kassio/neoterm'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'

  Plug 'neovim/nvim-lspconfig'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'Shougo/vimproc.vim',  { 'do': 'make' }
  Plug 'thinca/vim-quickrun'
  Plug 'osyo-manga/shabadou.vim'

  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'

  Plug 'chr4/nginx.vim'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'habamax/vim-asciidoctor'
  Plug 'hashivim/vim-terraform' , { 'for': 'terraform' }
  " Plug 'jxnblk/vim-mdx-js'
  " Plug 'sirtaj/vim-openscad'
  Plug 'vmchale/dhall-vim'
  Plug 'tsandall/vim-rego'

  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

call plug#end()

filetype plugin indent on

"========================================="
" Basic settings
"========================================="
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
set history=200
set incsearch
set ignorecase
set laststatus=2
set number
set nobackup
set noerrorbells
set nopaste
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
set termguicolors
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

syntax enable

augroup _ColorScheme
  autocmd!
  autocmd Colorscheme * highlight Normal ctermbg=none
  autocmd Colorscheme * highlight NonText ctermbg=none
  autocmd Colorscheme * highlight LineNr ctermbg=none ctermbg=none
  autocmd Colorscheme * highlight Folded ctermbg=none
  autocmd Colorscheme * highlight EndOfBuffer ctermbg=none
  autocmd Colorscheme * highlight Pmenu ctermbg=244 guibg=#1c1c1c
  autocmd Colorscheme * highlight Search ctermbg=none ctermbg=none
augroup END

"========================================="
" Keymap settings
"========================================="
let mapleader = ","
let g:mapleader = ","

nmap ; :Buffers
" nmap t :Files
" nmap r :Tags
nmap f :Rg<Space>

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>
inoremap <C-[> <ESC>

nnoremap <Leader>tt :Ttoggle<CR>
tnoremap <Leader>tt <C-\><C-n>:Ttoggle<CR>
silent! map <unique> <Leader>r <Plug>(quickrun)

tnoremap <C-[> <C-\><C-n>

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

" - highlight
nnoremap <silent> <C-L> :noh<C-L><CR>

" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

let s:ignore_patterns = [
    \ '__pycache__/',
    \ '__pycache__',
    \ '\.git',
    \ '\.gitmodules',
    \ '*\.csproj',
    \ '*\.meta',
    \ '*\.min\.js',
    \ '*\.o',
    \ '*\.pyc',
    \ '*\.sln',
    \ '*\.sqlite3',
    \ '*\.swp',
    \ '*\.unityproj',
    \ '*\.userprefs',
    \ '\.sass-cache',
    \ 'tags',
    \ ]

set wildignore+=\.hg,\.git,\.svn                      " Version control
set wildignore+=*\.aux,*\.out,*\.toc                  " LaTeX intermediate files
set wildignore+=*\.jpg,*\.bmp,*\.gif,*\.png,*\.jpeg   " binary images
set wildignore+=*\.o,*\.obj,*\.exe,*\.dll,*\.manifest " compiled object files
set wildignore+=*\.spl                                " compiled spelling word lists
set wildignore+=*\.sw?                                " Vim swap files
set wildignore+=*\.DS_Store                           " OSX bullshit
set wildignore+=*\.luac                               " Lua byte code
set wildignore+=*\.vagrant                            " Vagrant
set wildignore+=go/pkg                                " Go static files
set wildignore+=go/bin                                " Go bin files
set wildignore+=go/bin-vagrant                        " Go bin-vagrant files
set wildignore+=*\.pyc                                " Python byte code
set wildignore+=*/tmp/*,*\.so,*\.swp,*\.zip           " MacOSX/Linux
set wildignore+=*\\tmp\\*,*\.swp,*\.zip,*\.exe        " Windows
set wildignore+=*\.class                              " Java

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

"
" augroup TemplatesAu
"   autocmd!
"   autocmd BufNewFile *.c       0r $HOME/.vim/templates/tpl.c
"   autocmd BufNewFile *.cpp     0r $HOME/.vim/templates/tpl.cpp
"   autocmd BufNewFile *.cs      0r $HOME/.vim/templates/tpl.cs
"   autocmd BufNewFile *.go      0r $HOME/.vim/templates/tpl.go
"   autocmd BufNewFile *.html    0r $HOME/.vim/templates/tpl.html
"   autocmd BufNewFile *.java    call NewJavaFile()
"   autocmd BufNewFile *.proto   0r $HOME/.vim/templates/tpl.proto
"   autocmd BufNewFile *.py      0r $HOME/.vim/templates/tpl.py
"   autocmd BufNewFile *.rb      0r $HOME/.vim/templates/tpl.rb
"   autocmd BufNewFile *.service 0r $HOME/.vim/templates/tpl.service
"   autocmd BufNewFile Makefile  0r $HOME/.vim/templates/tpl.Makefile
"   autocmd BufNewFile README.md 0r $HOME/.vim/templates/tpl.README.md
"   autocmd BufNewFile docker-compose.* 0r $HOME/.vim/templates/tpl.docker-compose.yml
" augroup END

augroup FileTypeDetect
  autocmd!
  autocmd BufNewFile,BufRead *.{asciidoc,adoc,asc} set filetype=asciidoc
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf*  setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.cafe setf cafe
  autocmd BufNewFile,BufRead *.cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead *.dhall setlocal filetype=dhall tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead *.go,go.mod setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *.go.testing setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  " autocmd BufWritePre *.go GoFmt
  autocmd BufNewFile,BufRead *_test.go setlocal filetype=go.testing tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *_spec.rb set filetype=ruby.rspec
  autocmd BufNewFile,BufRead *.rego set filetype=rego tabstop=4 softtabstop=4 noexpandtab
  autocmd BufNewFile,BufRead *.coffee setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead Dockerfile*  setf dockerfile
  autocmd BufNewFile,BufRead .terraformrc  setf terraform
  autocmd FileType javascript setlocal smartindent cinwords=if,else,for,while,try,except,finally,def,class
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType cs setlocal  tabstop=4 shiftwidth=4 softtabstop=4
  " autocmd BufWritePre *.cs OmniSharpCodeFormat
  autocmd FileType yml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType scala setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType make setlocal noexpandtab
  autocmd FileType gitconfig setlocal noexpandtab
  autocmd FileType rego setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType hs setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType terraform setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

lua require("lsp_config")

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)
"if executable('gopls')
"  augroup LspGo
"    au!
"    autocmd User lsp_setup call lsp#register_server({
"        \ 'name': 'go-lang',
"        \ 'cmd': {server_info->['gopls']},
"        \ 'whitelist': ['go'],
"        \ 'workspace_config': {'gopls': {
"        \     'staticcheck': v:true,
"        \     'completeUnimported': v:true,
"        \     'usePlaceholders': v:true,
"        \     'completionDocumentation': v:true,
"        \     'hoverKind': 'SingleLine',
"        \   }},
"        \ })
"    autocmd FileType go setlocal omnifunc=lsp#complete
"    autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
"    autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
"    autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
"  augroup END
"endif
"
""
set list listchars=tab:»\ ,
set background=dark
colorscheme solarized

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

let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_default_mod = 'botright'

function! LightlineModified() abort
  return &buftype ==# 'terminal' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline = {
\   'colorscheme': 'powerline',
\   'active': {
\     'left': [
\       [ 'mode', 'paste' ],
\       [ 'branch' ],
\       [ 'readonly', 'filename', 'modified' ],
\     ],
\     'right': [
\       [ 'lineinfo' ],
\       [  ],
\       [ 'filetype' ],
\       [  ],
\       [ ],
\     ],
\   },
\   'inactive': {
\     'left': [
\       [  ],
\       [  ],
\       [ 'readonly', 'filename' ],
\     ],
\     'right': [
\       [ 'lineinfo' ],
\       [  ],
\       [ 'filetype' ],
\     ],
\   },
\   'component_function':{
\     'branch': 'fugitive#head',
\     'modified': 'LightlineModified',
\     'filename' : 'LightlineFilename'
\   },
\ }

" dirvish
augroup dirvish_commands
  autocmd!
  autocmd FileType dirvish nnoremap <silent> <buffer> <C-r> :<C-u>Dirvish %<CR>
  autocmd FileType dirvish unmap <silent> <buffer> <CR>
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish nnoremap <silent> <buffer> <CR> :<C-u> call <SID>dirvish_open()<CR>
  autocmd FileType dirvish setlocal nonumber norelativenumber
  autocmd FileType dirvish nnoremap <buffer><silent> <C-j> <C-\><C-n>j:call feedkeys("p")<CR>
  autocmd FileType dirvish nnoremap <buffer><silent> <C-k> <C-\><C-n>k:call feedkeys("p")<CR>
  "autocmd FileType dirvish silent! keeppatterns g@\v/\.[^\/]+/?$@d

  " au User DirvishEnter let b:dirvish.showhidden = 1
  for pat in s:ignore_patterns
    autocmd FileType dirvish silent! keeppatterns g@\v/\.pat./?$@d
  endfor
augroup END

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

let g:UltiSnipsExpandTrigger = "<tab>"

if !exists("g:UltiSnipsJumpForwardTrigger")
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
" fzf
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
let g:fzf_history_dir = '~/.config/local/share/fzf-history'

let g:quickrun_config = {'_': {}}
let g:quickrun_config._.input = '=@i'
let g:quickrun_config._.input = '=%{b:input}'

let g:quickrun_config = {
  \  '_' : {
  \    'runner' : 'vimproc',
  \    'runner/vimproc/updatetime' : 60,
  \    'hook/close_buffer/enable_failure': 1,
  \    'hook/close_buffer/enable_empty_data': 1,
  \    'hook/close_quickfix/enable_hook_loaded' : 1,
  \    'hook/close_quickfix/enable_success' : 1,
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
let g:quickrun_config.cafe = {
  \ 'cmdopt' : '-batch',
  \ 'command': 'cafeobj',
  \ 'exec' : '%c %o %s',
  \ 'outputter/buffer/split'  : 'vsplit',
  \ }
let g:quickrun_config.cpp = {
  \ 'cmdopt' : '-std=c++1z -Wall -Wextra -O2',
  \ 'command': 'clang++',
  \ 'exec' : ['%c %o %s -o %s:p:r', '%s:p:r %a'],
  \ }
let g:quickrun_config.dhall = {
  \ 'cmdopt' : '--file',
  \ 'command': 'dhall',
  \ 'exec' : '%c %o %s',
  \ 'outputter/buffer/split'  : 'vsplit',
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
  \ }
let g:quickrun_config.go = {
  \ 'type': 'go',
  \ 'command': 'go',
  \ 'exec': 'go run *.go',
  \ }
let g:quickrun_config['go.testing'] = {
  \ 'type': 'go',
  \ 'command': 'go',
  \ 'exec': '%c test -v *.go',
  \ }
let g:quickrun_config.rego = {
  \ 'cmdopt' : 'test',
  \ 'command': 'opa',
  \ 'exec' : '%c %o %s',
  \ }
let g:quickrun_config.swift = {
  \ 'type': 'swift',
  \ 'cmdopt': "-sdk `xcrun --show-sdk-path --sdk macosx`",
  \ 'command': 'xcrun',
  \ 'exec': '%c swift %s %o',
  \ }
let g:quickrun_config.haskell = {
  \ 'cmdopt' : 'runhaskell',
  \ 'command': 'stack',
  \ }
"""
command! RemoveAnsi %s/\e\[[0-9;]*m/
