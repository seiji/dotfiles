vim.o.autoread       = true
vim.o.autowrite      = true
vim.o.backspace      = 'indent,eol,start'
vim.o.clipboard      = 'unnamed,unnamedplus'
vim.o.confirm        = true
vim.o.encoding       = 'utf-8'
vim.o.expandtab      = true
vim.o.fileencodings  = 'utf-8,euc-jp,cp932,iso-2022-jp'
vim.o.fileformats    = 'unix,dos,mac'
vim.o.gdefault       = true
vim.o.hidden         = true
vim.o.hlsearch       = true
vim.o.history        = 1000
vim.o.ignorecase     = true
vim.o.incsearch      = true
vim.o.laststatus     = 2
vim.o.lazyredraw     = true
vim.o.nobackup       = true
vim.o.nocursorcolumn = true
vim.o.nocursorline   = true
vim.o.noerrorbells   = true
vim.o.nopaste        = true
vim.o.noshowmatch    = true
vim.o.noswapfile     = true
vim.o.nowritebackup  = true
vim.o.pastetoggle    = '<C-E>'
vim.o.re             = 1
vim.o.ruler          = true
vim.o.scrolloff      = 8
vim.o.shiftround     = true
vim.o.shiftwidth     = 2
vim.o.showcmd        = true
vim.o.showmode       = true
vim.o.smartcase      = true
vim.o.smartindent    = true
vim.o.softtabstop    = 2
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.synmaxcol      = 160
vim.o.tabstop        = 2
vim.o.termguicolors  = true
vim.o.title          = true
vim.o.ttyfast        = true
vim.o.wildmenu       = true
vim.o.wildmode       = 'full'
vim.o.wildignorecase = true
vim.o.wildignore     = '*/.hg,*/.git,*/.svn'
vim.o.wrapscan       = true
vim.wo.cursorline    = false
vim.wo.number        = true
vim.wo.wrap          = false

vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')
vim.cmd('syntax on')

function vim.fn.stripTrailingWhitespace()
  local l = vim.fn.line(".")
  local c = vim.fn.col(".")
  vim.cmd("%s/\\s\\+$//e")
  vim.fn.cursor(l, c)
end

-- autocmd BufEnter * call s:ChangeCurrentDirectory()
vim.cmd("autocmd BufWritePre * :lua vim.fn.stripTrailingWhitespace()")
vim.cmd("autocmd InsertLeave * set nopaste")