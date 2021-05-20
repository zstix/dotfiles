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

export NOTE_DIR=~/Dropbox/notes

#=================================================
# Features
#=================================================

# If a local config exists, load it
if [ -f ~/.local_zshrc ]; then
  . ~/.local_zshrc;
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

#=================================================
# Custom Functions
#=================================================

# Get the current branch (for the prompt)
function git_branch {
	# BRANCH="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)"
  BRANCH="$(git status 2>/dev/null | head -n 1 | awk '{print $3}')"
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

# Easy notes
function note() {
  TITLE="$@"
  FILENAME=$(date +'%Y-%m-%d')_${TITLE// /-}.md
  FILEPATH=$NOTE_DIR/$FILENAME

  cat $NOTE_DIR/templates/note.md | \
    sed "s/NAME/$TITLE/" | \
    sed "s/DATE/$(date +'%Y-%m-%d %H:%M')/" \
    > $FILEPATH

  vim $FILEPATH +6
}

# Easy meeting notes
function meeting() {
  TITLE="$@"
  FILENAME=$(date +'%Y-%m-%d')_${TITLE// /-}.md
  FILEPATH=$NOTE_DIR/$FILENAME

  cat $NOTE_DIR/templates/meeting.md | \
    sed "s/NAME/$TITLE/" | \
    sed "s/DATE/$(date +'%Y-%m-%d %H:%M')/" \
    > $FILEPATH

  vim $FILEPATH +4
}

#=================================================
# Prompt
#=================================================

function precmd() {
	PROMPT="
%{$fg[white]%}$(whoami)@%m %{$reset_color%}%{$fg[gray]%}%~ $(git_branch)%{$reset_color%}
> "
}

