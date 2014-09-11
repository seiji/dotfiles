" = Skelton
augroup TemplatesAu
  autocmd!
  autocmd BufNewFile *.rb 0r $HOME/.vim/templates/tpl.rb
  autocmd BufNewFile *.go 0r $HOME/.vim/templates/tpl.go
  autocmd BufNewFile *.html 0r $HOME/.vim/templates/tpl.html
augroup END

" Perl
autocmd FileType perl :map <C-n> <ESC>:!perl -cw %<CR>
autocmd FileType perl :map <C-e> <ESC>:!perl %<CR>
" Ruby
autocmd FileType ruby :map <C-n> <ESC>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>
" JavaScript
autocmd Filetype javascript setl autoindent
autocmd FileType javascript setl smartindent cinwords=if,else,for,while,try,except,finally,def,class
autocmd FileType javascript setl expandtab tabstop=2 shiftwidth=2 softtabstop=0
" Go
auto BufWritePre *.go Fmt  

