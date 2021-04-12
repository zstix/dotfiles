# Personal .zshrc file
# Author:      Zack Stickles <https://github.com/zstix>
# Last Change: 2020-04-12
# License:     This file is placed in the public domain.

#=================================================
# General
#=================================================

autoload -Uz compinit && compinit # Enable auto-completion
autoload -U colors && colors      # Enable colors

#=================================================
# Variables / Aliases
#=================================================

alias cat="bat"
export BAT_THEME="base16"

export FZF_DEFAULT_OPTS='
--color fg:14,fg+:3,hl:5,hl+:5,bg:-1,bg+:-1
--color info:6,prompt:6,spinner:1,pointer:3
--preview-window=noborder:60%
'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#=================================================
# Features
#=================================================

# If a local config exists, load it
if [ -f ~/.local_zshrc ]; then
  . ~/.local_zshrc;
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#=================================================
# Custom Functions
#=================================================

# Get the current branch (for the prompt)
function git_branch {
	BRANCH="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)"
	if ! test -z $BRANCH; then
		COL="%{$fg[green]%}"
		[[ $(git log origin/main..HEAD 2> /dev/null ) != "" ]] && COL="%{$fg[blue]%}"
		[[ $(git status --porcelain 2> /dev/null) != "" ]] && COL="%{$fg[red]%}"
		echo "$COL($BRANCH)"
	fi
}

# Easy searching
function search() {
  DIR="."
  if [[ $2 ]]; then DIR=$2; fi
  grep -rni --color=always $1 $DIR
}

#=================================================
# Prompt
#=================================================

function precmd() {
	PROMPT="
%{$fg[white]%}$(whoami)@%m %{$reset_color%}%{$fg[gray]%}%~ $(git_branch)%{$reset_color%}
> "
}

