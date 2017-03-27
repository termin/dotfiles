# Path
export PATH=~/bin:$PATH
# Macは/etc/pathsでも設定

# readlineのC-sを使える様に
stty stop undef

if [ -x /usr/local/bin/vim ]; then
	export EDITOR=/usr/local/bin/vim
	export SUDO_EDITOR=/usr/local/bin/vim
fi

if [[ $BASH_VERSINFO -ge 4 ]]; then
	shopt -s globstar
fi
shopt -s dirspell # 動かないなんで
shopt -s no_empty_cmd_completion
shopt -s checkjobs
# shopt -s cmdhist
# shopt -s lithist
# shopt -s extglob

# source /usr/local/Cellar/coreutils/8.15/aliases
# PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export LESS="-MR"
# if which gls > /dev/null; then
	# alias ls='gls -F --color=always'
# fi
alias ls='ls -FG'
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
	# bash_completion2
	if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
		. $(brew --prefix)/share/bash-completion/bash_completion
	fi

	# bash-git-prompt
	# if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
	# 	# GIT_PROMPT_THEME=Default
	# 	source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
	# fi

	# git
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWSTASHSTATE=true
	# \j     the number of jobs currently managed by the shell
	case "$TERM" in
		xterm*|rxvt*|putty*|screen*)
			PS1='\[\e[1;34m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\w\[\e[0m\]$(__git_ps1)$(if [ \j -ne 0 ]; then echo "[\j]"; fi)\n\$ '
			;;
		*)
			PS1='[$(date +%H:%M:%S)(\#)]\u@\h:\w\$ '
			;;
	esac

	# z.sh
	if [ -f `brew --prefix`/etc/profile.d/z.sh ]; then
		_Z_CMD=j
		. `brew --prefix`/etc/profile.d/z.sh
	fi
fi

# golang
export GOPATH="$HOME/gocode"
export PATH=$PATH:$GOPATH/bin
