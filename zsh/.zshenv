# debug
#set -x

if [ -x /usr/libexec/path_helper ]; then
  PATH=''
  eval `/usr/libexec/path_helper -s`
fi
. ~/.zsh/env
