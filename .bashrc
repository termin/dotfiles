export LANG=ja_JP.UTF-8

# readlineのC-sを使える様に
stty stop undef

if [ -x /opt/homebrew/bin/vim ]; then
	export EDITOR=/opt/homebrew/bin/vim
	export SUDO_EDITOR=/opt/homebrew/bin/vim
fi

if [[ $BASH_VERSINFO -ge 4 ]]; then
	shopt -s globstar
fi
shopt -s dirspell
shopt -s no_empty_cmd_completion
shopt -s checkjobs
# shopt -s cmdhist
# shopt -s lithist
# shopt -s extglob
shopt -s checkwinsize	# 端末のウィンドウサイズを${COLUMNS}と${LINES}に反映
shopt -s histappend		# 履歴を上書きせず追加のみ行う

stty werase undef
bind '\C-w:unix-filename-rubout'

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
alias info='info --vi-keys'

if which colordiff > /dev/null; then
	alias diff='colordiff'
fi

if [[ $TERM != xterm* ]]; then
	alias ssh='TERM=xterm-256color ssh'
fi

# erutaso
if which erutaso > /dev/null; then
	alias sl='erutaso -a'
fi

if which brew > /dev/null; then
	# bash_completion@2
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

	# git-prompt.shはbash-completionのディレクトリに入っていて読み込み済み
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWSTASHSTATE=true
	case "$TERM" in
		xterm*|rxvt*|putty*|screen*|alacritty)
			PS1='\[\e[1;34m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\w\[\e[0m\]$(__git_ps1)$(if [ \j -ne 0 ]; then echo "[\j]"; fi)\n\$ '
			;;
		*)
			PS1='[$(date +%H:%M:%S)(\#)]\u@\h:\w\$ '
			;;
	esac
fi

alias pip3_update_all="pip3 list --outdated --format freeze | awk -F = '{print $1}' | xargs pip3 install -U pip"
# alias pip2_update_all="pip2 list --outdated --format freeze | awk -F = '{print $1}' | xargs pip2 install -U pip"

