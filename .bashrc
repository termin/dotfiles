# Dev_android
export PATH=/Developer/android-sdk-mac_x86/tools:$PATH
export EDITOR=/opt/local/bin/vi

# MacPorts Installer addition on 2009-10-06_at_10:19:43: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts用
export MANPATH=/opt/local/man:$MANPATH

alias less='less -MR'
alias grep='grep --color'
alias ls='gls -Fh --color'
alias ll='ls -l'
alias la='ls -A'

shopt -s checkwinsize	# 端末のウィンドウサイズを${COLUMNS}と${LINES}に反映
shopt -s histappend		# 履歴を上書きせず追加のみ行う

# bash_completion
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi

# This loads RVM into a shell session.
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

