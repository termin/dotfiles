# Path
export PATH=~/bin:/usr/local/sbin:$PATH
# Dev_android
# export PATH=$PATH:/Developer/android-sdk-mac_x86/tools:/Developer/android-sdk-mac_x86/platform-tools

export EDITOR=/usr/local/bin/vim
export SUDO_EDITOR=/usr/local/bin/vim

# export ECLIPSE_HOME=/Applications/apps/eclipse
# alias eclimd='$ECLIPSE_HOME/eclimd&'

# source /usr/local/Cellar/coreutils/8.15/aliases
# PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export LESS="-MR"
# alias less='less -MR'
alias grep='grep --color'
alias ls='gls -Fh --color=always'
alias ll='ls -l'
alias la='ls -A'

alias sudo='sudo '
alias sude='sudo -e'

alias info='info --vi-keys'

alias refe='/Users/termin/refm/refe-1_9_2'

alias vi='vim'
alias be='bundle exec'

shopt -s checkwinsize	# 端末のウィンドウサイズを${COLUMNS}と${LINES}に反映
shopt -s histappend		# 履歴を上書きせず追加のみ行う

# bash_completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
fi

# rbenv
eval "$(rbenv init -)"

