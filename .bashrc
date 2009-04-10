# Lang
#export LANG=ja_JP.UTF-8
#export LC_CTYPE=ja_JP.UTF-8


# MacPorts
export PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin/:$PATH
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

# Flex3
export PATH=$HOME/local/flex_sdk_3/bin:$PATH

alias ll='ls -la'
alias ls='ls -1'
alias grep='grep -n'
alias firefox="open -a Firefox"
alias safari="open -a Safari"
alias prev="open -a Preview"
alias fcd="source /Users/toyamaseiji/bin/fcd.sh"
#alias screen='/usr/local/screen/bin/screen'
alias sc='screen -U -D -RR'
alias cot='open -a CotEditor'

export PS1="$ "
