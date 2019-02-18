# View .inputrc
. ~/.zsh/rc
[ -f ~/.zsh/antigen/antigen.zsh ] && source ~/.zshrc.antigen

if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
