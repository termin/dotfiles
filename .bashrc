# Path
# export PATH=$PATH:/usr/local/sbin
# Dev_android
# export PATH=$PATH:/Developer/android-sdk-mac_x86/tools:/Developer/android-sdk-mac_x86/platform-tools

export EDITOR=/usr/local/bin/vim

# export ECLIPSE_HOME=/Applications/apps/eclipse
# alias eclimd='$ECLIPSE_HOME/eclimd&'

# source /usr/local/Cellar/coreutils/8.11/aliases
alias less='less -MR'
alias grep='grep --color'
alias ls='gls -Fh --color'
alias ll='ls -l'
alias la='ls -A'

alias sudo='sudo '
alias sudi='sudo vi'

shopt -s checkwinsize	# 端末のウィンドウサイズを${COLUMNS}と${LINES}に反映
shopt -s histappend		# 履歴を上書きせず追加のみ行う

# bash_completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
fi

[[ -s "/Users/termin/.rvm/scripts/rvm" ]] && source "/Users/termin/.rvm/scripts/rvm"  # This loads RVM into a shell session.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
