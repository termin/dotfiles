# Path
export PATH=~/bin:$PATH
# Macは/etc/pathsでも設定

# readlineのC-sを使える様に
stty stop undef

export EDITOR=/usr/local/bin/vim
export SUDO_EDITOR=/usr/local/bin/vim

# source /usr/local/Cellar/coreutils/8.15/aliases
# PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export LESS="-MR"
if which gls > /dev/null; then
	alias ls='gls -F --color=always'
fi
# alias ls='ls -FG'
alias l='ls'
alias ll='ls -lh'
alias la='ls -A'
alias grep='grep --color'
alias sudo='sudo '
alias sude='sudo -e'
alias info='info --vi-keys'
alias vi='vim'
alias be='bundle exec'

shopt -s checkwinsize	# 端末のウィンドウサイズを${COLUMNS}と${LINES}に反映
shopt -s histappend		# 履歴を上書きせず追加のみ行う

# erutaso
if which erutaso > /dev/null; then
	alias sl='erutaso -a'
fi

if which brew > /dev/null; then
	# bash_completion
	# if [ -f $(brew --prefix)/etc/bash_completion ]; then
		# . $(brew --prefix)/etc/bash_completion
	# fi

	# cf. 『bash_completionで「-bash: __git_ps1: command not found」となった時の対処法 - くりにっき』 http://sue445.hatenablog.com/entry/2012/08/30/005627
	# if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
		# source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
	# fi

	# bash_completion2
	if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
		. $(brew --prefix)/share/bash-completion/bash_completion
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
GIT_PS1_SHOWDIRTYSTATE=true
# PS1='\[\033[32m\]\[\033[00m\]\[\033[34m\]\w\[\033[31m\]$(__git_ps1 " [%s]")\[\033[00m\]\$ '
case "$TERM" in
	xterm*|rxvt*|putty*|screen*)
		PS1='${debian_chroot:+($debian_chroot)}\[\e[1;32m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\w\[\e[0m\]$(__git_ps1)\$ '
		;;
	*)
		PS1='${debian_chroot:+($debian_chroot)}[$(date +%H:%M:%S)(\#)]\u@\h:\w\$ '
		;;
esac

# golang
export GOPATH="$HOME/gocode"
export PATH=$PATH:$GOPATH/bin

# Android Development Tools
export PATH=$PATH:~/Dev/adt/sdk/platform-tools

# docker
export DOCKER_HOST=tcp://:2375
