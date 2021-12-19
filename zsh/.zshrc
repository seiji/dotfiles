# View .inputrc
. ~/.zsh/rc
[ -f `brew --prefix`/share/antigen/antigen.zsh ] && source ~/.zshrc.antigen

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(goenv init -)"
