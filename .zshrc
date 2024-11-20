# vim: set ts=4 sw=4 sts=4 noexpandtab:

ZVM_INIT_MODE=sourcing
eval "$(sheldon source)"
eval "$(direnv hook zsh)"

# readlineのC-sを使える様に
stty stop undef

# zsh-vi-modeが設定する
if ! (type zvm_version > /dev/null 2>&1); then
	bindkey -v
	bindkey -M viins '^A' beginning-of-line
	bindkey -M viins '^B' backward-char
	bindkey -M viins '^E' end-of-line
	bindkey -M viins '^F' forward-char
	bindkey -M viins '^H' backward-delete-char
	bindkey -M viins '^N' down-line-or-history
	bindkey -M viins '^P' up-line-or-history
	bindkey -M viins '^U' backward-kill-line
	bindkey -M viins '^W' backward-kill-word
fi
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^S' history-incremental-pattern-search-forward

HISTSIZE=5000
SAVEHIST=10000

# ^wでスラッシュまでを削除
autoload -U select-word-style
select-word-style bash

if [ -x /opt/homebrew/bin/vim ]; then
	export EDITOR=/opt/homebrew/bin/vim
	export SUDO_EDITOR=/opt/homebrew/bin/vim
fi

export LESS="-MR"
alias ls='ls -FG'
alias l='ls'
alias ll='ls -lh'
alias la='ls -A'
alias grep='grep --color'
alias sudo='sudo '
alias info='info --vi-keys'
alias diff='diff --color=auto'

if [[ $TERM != xterm* ]]; then
	alias ssh='TERM=xterm-256color ssh'
fi

if which erutaso > /dev/null; then
	alias sl='erutaso -a'
fi

if (which sheldon > /dev/null 2>&1); then
	autoload -Uz compinit; compinit
fi

zstyle ':completion:*' menu select
# 大文字小文字無視, 但し大文字入力の場合は小文字を対象としない
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# setopt list_packed
autoload -Uz colors
zstyle ':completion:*' list-colors ''

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

PROMPT_FORMAT_LINE1=$'%B%F{blue}%n@%m%f%b:%B%F{blue}%~%f%b $(gitprompt)%1(j.[%j].)'
PROMPT_FORMAT_LINE2='%# '
function make_prompt {
	local color="red"
	if [[ "$1" == "INSERT" ]]; then
		color="blue"
	fi
	echo "${PROMPT_FORMAT_LINE1} %B%F{$color}[$1]%f%b \n${PROMPT_FORMAT_LINE2}"
}

# TODO: 起動直後に発火させたい
# INSERTモード以外の場合を明示したいのが一番のモチベーションなので困らない気はする
function zvm_after_select_vi_mode {
	local -A modes
	modes=(n NORMAL i INSERT r REPLACE v VISUAL vl V-LINE)
	local mode_name=$modes[$ZVM_MODE]
	if [[ -z "${mode_name}" ]]; then
		return
	fi
	local new_prompt="$(make_prompt ${mode_name})"
	if [[ "${RPROMPT}" != "${new_prompt}" ]]; then
		PROMPT=$new_prompt
		zle reset-prompt
	fi
}

# 方針
# * 移植性を考えてZLEより素朴なfunctionを優先
# * その場で実行する系はaliasにする
# * その場で実行せず行編集したいだけならZLE
# * ZLEを使う場合 出来るだけhistoryにコマンド名を残す
#     * ログを読みやすい
#     * history利用しやすい
#     * 例えば
#        * 実際に動かすfunctionを発火するだけのfunctionを作ってそれをbindkeyする
#        * 自分自身のfunctionをechoする
if which fzf > /dev/null; then
	export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border --bind=ctrl-f:page-down,ctrl-b:page-up,home:first,end:last'
	export FZF_CTRL_R_OPTS="--prompt='history > '"
	export FZF_CTRL_T_OPTS="--prompt='file > '"
	export FZF_ALT_C_OPTS="--prompt='cd > '"
	export FZF_CTRL_T_COMMAND="fd --hidden --no-ignore-vcs"
	export FZF_ALT_C_COMMAND="fd --type d --hidden --no-ignore-vcs"

	FZF_CTRL_T_COMMAND= \
	FZF_ALT_C_COMMAND= \
	source <(fzf --zsh)

	# fzf-history-widget CTRL-Rだけ無効化出来ないので上書き
	bindkey -M viins '^R' history-incremental-pattern-search-backward
	bindkey -M vicmd "^R" redo
fi

# ^jはprefixとして使う
# cf. https://github.com/warpdotdev/Warp/issues/1694
if [[ ${TERM_PROGRAM:=unknown} != WarpTerminal ]]; then
	bindkey -rM vicmd '^j'
	bindkey -rM viins '^j'
fi

function list-user-defined-aliases-and-keymaps {
	echo "\n# Aliases"
	alias cdh cdp
	echo
	echo "# Keymaps"
	bindkey -L -M viins | grep "\"^J" | awk '{print $3,$4,$5}'
}
# 実際に動かしたコマンド名をログに残す為のfunction
function list-user-defined-aliases-and-keymaps-fire {
	# 別にfunction名をechoするだけでも良いけれども
	BUFFER="list-user-defined-aliases-and-keymaps"
	CURSOR=$#BUFFER
	zle accept-line
}
zle -N list-user-defined-aliases-and-keymaps-fire
bindkey -M viins '^j?' list-user-defined-aliases-and-keymaps-fire

# initialize cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
	autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
	add-zsh-hook chpwd chpwd_recent_dirs
	zstyle ':chpwd:*' recent-dirs-default true
	zstyle ':completion:*:*:cdr:*:*' menu selection
	zstyle ':completion:*' recent-dirs-insert both
	zstyle ':chpwd:*' recent-dirs-max 100
	zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"

	# 存在しないディレクトリをcdrから削除
	# cf. https://blog.n-z.jp/blog/2014-07-25-compact-chpwd-recent-dirs.html
	function prune-missing-chpwd-recent-dirs {
		emulate -L zsh
		setopt localoptions extendedglob
		local -aU reply
		integer history_size
		autoload -Uz chpwd_recent_filehandler
		chpwd_recent_filehandler
		history_size=$#reply
		reply=(${^reply}(N))
		(( $history_size == $#reply )) || chpwd_recent_filehandler $reply
	}
	prune-missing-chpwd-recent-dirs
fi

# cdrの履歴をインタラクティブに検索してcdする
function cd-history-interactive {
	local p=$(cdr -l | awk '{ print $2 }' | $(__fzfcmd) --prompt="cdr >" | sed -e "s|^~|$HOME|g")
	if [ -n $p ]; then
	   echo "cd ${p}"
		cd $p
	fi
}
alias cdh="cd-history-interactive"

function cd-project-interactive {
	cd "$(ghq list --full-path | $(__fzfcmd) --prompt='project >')"
}
alias cdp="cd-project-interactive"

function cd-find {
	setopt localoptions pipefail no_aliases 2> /dev/null
	local dir="$(
		FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-} \
		FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-} +m") \
		$(__fzfcmd) < /dev/tty
	)"
	if [[ -z "$dir" ]]; then
		return 0
	fi
	echo "cd ${(qqq)dir:a}"
	builtin cd -- ${(q)dir:a}
}
alias cdf=cd-find

zle -N fzf-history-widget
bindkey -M viins '^jr' fzf-history-widget
bindkey -M viins '^j^r' fzf-history-widget

zle -N fzf-file-widget
bindkey -M viins '^jf' fzf-file-widget
# zle -N fzf-cd-widget
# bindkey -M viins '^jc' fzf-cd-widget

alias pip3_update_all="pip3 list --outdated --format freeze | awk -F = '{print $1}' | xargs pip3 install -U pip"

source ${HOME}/.zshrc.private

# if (which zprof > /dev/null 2>&1); then
# 	zprof
# fi

