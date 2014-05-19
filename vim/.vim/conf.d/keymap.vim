"=== KeyMap
"noremap ; :
"noremap : ;

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>
inoremap <C-j> <ESC>

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

nnoremap <S-Tab> gt
nnoremap <Tab><Tab> gT
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor
