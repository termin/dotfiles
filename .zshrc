bindkey -v
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word

if [ -x /opt/homebrew/bin/vim ]; then
	export EDITOR=/opt/homebrew/bin/vim
	export SUDO_EDITOR=/opt/homebrew/bin/vim
fi

# ^wでスラッシュまでを削除
autoload -U select-word-style
select-word-style bash

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

# if which brew > /dev/null; then
# 	case "$TERM" in
# 		xterm*|rxvt*|putty*|screen*)
# 			PS1='\[\e[1;34m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\w\[\e[0m\]$(__git_ps1)$(if [ \j -ne 0 ]; then echo "[\j]"; fi)\n\$ '
# 			# PS1='\[\e[1;34m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\w\[\e[0m\]$(if [ \j -ne 0 ]; then echo "[\j]"; fi)\n\$ '
# 			;;
# 		*)
# 			PS1='[$(date +%H:%M:%S)(\#)]\u@\h:\w\$ '
# 			;;
# 	esac
# fi

autoload -Uz compinit
compinit 
# 大文字小文字無視, 但し大文字入力の場合は小文字を対象としない
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# setopt list_packed
autoload colors
zstyle ':completion:*' list-colors ''

alias pip3_update_all="pip3 list --outdated --format freeze | awk -F = '{print $1}' | xargs pip3 install -U pip"
# alias pip2_update_all="pip2 list --outdated --format freeze | awk -F = '{print $1}' | xargs pip2 install -U pip"

