# View .inputrc
. ~/.zsh/rc

case ${OSTYPE} in
  darwin*)
    [ -f `brew --prefix`/share/antigen/antigen.zsh ] && source ~/.zshrc.antigen
    ;;
  linux*)
    [ -f /usr/share/zsh/share/antigen.zsh ] && source ~/.zshrc.antigen
    ;;
esac
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#eval "$(goenv init -)"

. "$HOME/.local/share/../bin/env"
