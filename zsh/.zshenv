# debug
#set -x

if [ -x /usr/libexec/path_helper ]; then
  PATH=''
  eval `/usr/libexec/path_helper -s`
fi

[ -x /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)
. ~/.zsh/env
