eval "$(sheldon source)"

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

if (which sheldon > /dev/null 2>&1); then
	autoload -Uz compinit; compinit
fi

# 大文字小文字無視, 但し大文字入力の場合は小文字を対象としない
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# setopt list_packed
autoload -Uz colors
zstyle ':completion:*' list-colors ''

# if [[ -r "/opt/homebrew/opt/git/etc/bash_completion.d/git-prompt.sh" ]]; then
# 	source /opt/homebrew/opt/git/etc/bash_completion.d/git-prompt.sh
# 	GIT_PS1_SHOWDIRTYSTATE=true
# 	GIT_PS1_SHOWSTASHSTATE=true
# 	case "$TERM" in
# 		xterm*|rxvt*|putty*|screen*|alacritty)
# 			setopt PROMPT_SUBST
# 			PROMPT=$'%B%F{blue}%n@%m%f%b:%B%F{blue}%~%f%b$(__git_ps1)%1(j.[%j].)\n%# '
# 			;;
# 	esac
# fi

# dev
# source ~/.zsh/dev/git-prompt.zsh/git-prompt.zsh

ZSH_GIT_PROMPT_FORCE_BLANK=1
ZSH_GIT_PROMPT_SHOW_STASH=1
ZSH_GIT_PROMPT_SHOW_COUNT_UNMERGED=0
ZSH_GIT_PROMPT_SHOW_COUNT_STAGED=0
ZSH_GIT_PROMPT_SHOW_COUNT_UNSTAGED=0
ZSH_GIT_PROMPT_SHOW_COUNT_UNTRACKED=0
ZSH_GIT_PROMPT_SHOW_COUNT_STASHED=0
ZSH_GIT_PROMPT_SHOW_UPSTREAM="full"
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[yellow]%}→ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_no_bold[cyan]%}detached"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_no_bold[cyan]%}behind"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_no_bold[cyan]%}ahead"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}*"
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}<stashed>"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT=$'%B%F{blue}%n@%m%f%b:%B%F{blue}%~%f%b $(gitprompt)%1(j.[%j].)\n%# '
RPROMPT=''

alias pip3_update_all="pip3 list --outdated --format freeze | awk -F = '{print $1}' | xargs pip3 install -U pip"
# alias pip2_update_all="pip2 list --outdated --format freeze | awk -F = '{print $1}' | xargs pip2 install -U pip"

# if (which zprof > /dev/null 2>&1); then
# 	zprof
# fi

