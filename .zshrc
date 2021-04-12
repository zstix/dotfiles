# Personal .zshrc file
# Author:      Zack Stickles <https://github.com/zstix>
# Last Change: 2020-04-11
# License:     This file is placed in the public domain.

#=================================================
# General
#=================================================

autoload -Uz compinit && compinit # Enable auto-completion
autoload -U colors && colors      # Enable colors

#=================================================
# Custom Functions
#=================================================

function git_branch {
	BRANCH="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)"
	if ! test -z $BRANCH; then
		COL="%{$fg[green]%}" # Everything's fine
		[[ $(git log origin/master..HEAD 2> /dev/null ) != "" ]] && COL="%{$fg[blue]%}" # We have changes to push
		[[ $(git status --porcelain 2> /dev/null) != "" ]] && COL="%{$fg[red]%}" # We have uncommited changes
		echo "$COL($BRANCH)"
	fi
}

#=================================================
# Prompt
#=================================================

function precmd() {
	PROMPT="%{$fg[gray]%}$(whoami)@%m %{$fg[white]%}%~ $(git_branch)%{$reset_color%}$ "
}

