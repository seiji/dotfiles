let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

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

"========================================="
" Keymap settings
"========================================="
nmap ; :Buffers
nmap t :Files
nmap r :Tags

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
let s:ignore_patterns = [
    \ '__pycache__/',
    \ '__pycache__',
    \ '\.git',
    \ '\.gitmodules',
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

augroup FileTypeDetect
  autocmd!
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf*  setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *.go setlocal noet tabstop=4 shiftwidth=4 softtabstop=4
  " autocmd BufWritePre *.go GoFmt
  autocmd BufNewFile,BufRead *_test.go set filetype=go.testing
  autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *_spec.rb set filetype=ruby.rspec
  autocmd BufNewFile,BufRead *.coffee setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType javascript setlocal smartindent cinwords=if,else,for,while,try,except,finally,def,class
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType cs setlocal  tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufWritePre *.cs OmniSharpCodeFormat
  autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead Dockerfile*  setf dockerfile
  autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END
"========================================="
" plugin Manager: dein.vim setting
"========================================="
if &compatible
 set nocompatible
endif

let s:dein_dir = expand('$CACHE/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:conf_dir    = expand('$CONFIG/nvim/conf')
  let s:toml      = g:conf_dir . '/dein.toml'
  let s:lazy_toml = g:conf_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

let g:dein#install_max_processes = 16
""
