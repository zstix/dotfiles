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
		COL="%{$fg[green]%}("
		[[ $(git log origin/HEAD..HEAD 2> /dev/null ) != "" ]] && COL="%{$fg[blue]%}(^"
		[[ $(git status --porcelain 2> /dev/null) != "" ]] && COL="%{$fg[red]%}(+"
		echo "$COL$BRANCH)"
	fi
}

#=================================================
# Prompt
#=================================================

function precmd() {
	PROMPT="
%{$fg[gray]%}$(whoami)@%m %{$fg[white]%}%~ $(git_branch)%{$reset_color%}
> "
}

