# Path
export PATH=~/bin:$PATH
# Macは/etc/pathsでも設定

# readlineのC-sを使える様に
stty stop undef

export EDITOR=/usr/local/bin/vim
export SUDO_EDITOR=/usr/local/bin/vim

# export ECLIPSE_HOME=/Applications/apps/eclipse
# alias eclimd='$ECLIPSE_HOME/eclimd&'

# source /usr/local/Cellar/coreutils/8.15/aliases
# PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export LESS="-MR"
alias grep='grep --color'
if which gls > /dev/null; then
	alias ls='gls -Fh --color=always'
fi
alias l='ls'
alias ll='ls -l'
alias la='ls -A'

alias sudo='sudo '
alias sude='sudo -e'

alias info='info --vi-keys'

alias vi='vim'
alias be='bundle exec'

shopt -s checkwinsize	# 端末のウィンドウサイズを${COLUMNS}と${LINES}に反映
shopt -s histappend		# 履歴を上書きせず追加のみ行う

if which brew > /dev/null; then
	# bash_completion
	if [ -f `brew --prefix`/etc/bash_completion ]; then
		. `brew --prefix`/etc/bash_completion
	fi

	# z.sh
	_Z_CMD=j
	. `brew --prefix`/etc/profile.d/z.sh
fi

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# To use Homebrew's directories rather than ~/.rbenv add to your profile:
# export RBENV_ROOT=/usr/local/opt/rbenv

# git
# GIT_PS1_SHOWDIRTYSTATE=true
# PS1='\[\033[32m\]\[\033[00m\]\[\033[34m\]\w\[\033[31m\]$(__git_ps1 " [%s]")\[\033[00m\]\$ '
