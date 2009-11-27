# Lang
#export LANG=ja_JP.UTF-8
#export LC_CTYPE=ja_JP.UTF-8

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# MacPorts
export PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH

# libGD
export PATH=/usr/local/libgd/bin:$PATH

# Terminal
export CLICOLOR=1
export TERM=xterm-color
#export LSCOLORS=gxxxxxxxbxxxxxxxxxxxxx
export LSCOLORS=gxxxxxxxxxxxxxxxxxxxxx

# CVS 
export CVSROOT=:pserver:seiji@cvs.data-hotel.net:/usr/local/share/CVS

# Go
export GOROOT=$HOME/go
export GOOS=darwin
export GOARCH=amd64
export GOBIN=$GOROOT/bin
export PATH=$GOBIN:$PATH

# Flex3
export PATH=$HOME/local/flex_sdk_3/bin:$PATH

alias ll='ls -la'
alias ls='ls -1'
alias grep='grep -in --color'
alias firefox="open -a Firefox"
alias safari="open -a Safari"
alias prev="open -a Preview"
alias fcd="source /Users/toyamaseiji/bin/fcd.sh"
alias sc='screen -U -D -RR'
alias em='emacs'
alias xattr_w='xattr -w com.apple.metadata:kMDItemFinderComment'

export PS1="$ "

function pgrep() {
    if [ $# != 0 ]; then
        ps auxw | head -n 1
        ps auxw | grep $* | grep -v grep | grep -v "ps auxw"
    else
        echo "Usage: psgrep PATTERN"
    fi
}

