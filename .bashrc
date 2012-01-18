# Please save this file
# View .inputrc .bashrc
TERM=linux

#editor
export EDITOR=emacs

#env
#export LANG="ja_JP.UTF-8"

#color
export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=Gxfxcxdxhxegedahagacgx
#export PATH=/opt/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH

export MANPATH=/opt/local/man:$MANPATH

export PATH=/opt/subversion/bin:$PATH

# HomeBrew
export NODE_PATH=/usr/local/lib/node

# JAVA
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export PATH=$JAVA_HOME/bin:$PATH
export MAVEN_HOME=/usr/local/maven
export PATH=$MAVEN_HOME/bin:$PATH
export ANT_OPTS=-Dfile.encoding=UTF8

export HADOOP_HOME=/usr/local/hadoop
export PATH=$HADOOP_HOME/bin:$PATH
export MAHOUT_HOME=/usr/local/mahout
export PATH=$MAHOUT_HOME/bin:$PATH

# Android
export PATH=$PATH:/Applications/android-sdk-mac_x86/tools
export PATH=$PATH:/Applications/android-sdk-mac_x86/platform-tools

# MySQL
export MYSQL_HOME=/opt/local/lib/mysql5
export PATH=$PATH:$MYSQL_HOME/bin

#grep $today /usr/share/calendar/calendar.music
#grep $today /usr/share/calendar/calendar.history
#grep $today /usr/share/calendar/calendar.computer
#grep $today /usr/share/calendar/calendar.birthday


#base
alias ls="ls -1G"
alias ll="ls -la"
alias vi="/usr/bin/vim"
alias grep="grep -in --color"
alias screen='screen -U -D -RR'

#
#alias emacs="open -a Emacs"
alias firefox="open -a Firefox"
alias safari="open -a Safari"
alias prev="open -a Preview"
alias qlook="qlmanage -p"

alias fcd='source ~/bin/fcd.sh'
alias sc='screen -U -D -RR'
alias em='emacs'
alias xattr_w='xattr -w com.apple.metadata:kMDItemFinderComment'


#if [ -z "$STY" ]; then
#    exec screen -U -D -RR
#fi
case "${TERM}" in
dumb | emacs)
    PROMPT="%n@%~%(!.#.$)"
    RPROMPT=""
    unsetopt zle
    ;;
esac

export PS1="$ "
function pgrep() {
    if [ $# != 0 ]; then
        ps auxw | head -n 1
        ps auxw | grep $* | grep -v grep | grep -v "ps auxw"
    else
        echo "Usage: psgrep PATTERN"
    fi
}

eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
source $HOME/perl5/perlbrew/etc/bashrc

# tmux
#test -f ~/.tmuxrc && . ~/.tmuxrc
