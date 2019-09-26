# PS1 + Git

function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
    echo "(${BRANCH}${STAT})"
	else
		echo ""
	fi
}
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# export PS1="\n\[\e[34m\][\[\e[m\]\[\e[34m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[34m\]]\[\e[m\]\[\e[36m\][\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[36m\]]\[\e[m\]\[\e[32m\]\`parse_git_branch\`\[\e[m\]\\$ "

RED="\[\e[0;31m\]"
GRN="\[\e[0;32m\]"
YLW="\[\e[0;33m\]"
BLU="\[\e[0;34m\]"
PRP="\[\e[0;35m\]"
TEA="\[\e[0;36m\]"
RST="\[\e[0m\]"

# NOTE: this will need to be overwritten depending on OS
MY_IP=$(ifconfig | grep "inet " | grep -v "127.0.0.1" | tail -n 1 | sed -E 's/.*inet (.*)  netmask.*/\1/')

USR="$BLU\u$RST"
CMP="$TEA@$MY_IP$RST"
DIR="$GRN:\W$RST"
GIT="$PRP\`parse_git_branch\`$RST"

export PS1="$USR$CMP$DIR$GIT\$ "

# Global Configuration

export EDITOR="vim"
set -o emacs

export CLICOLOR=YES

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

shopt -s cdspell
shopt -s histappend

# Aliases

alias dir="ls -lahF"
alias fdir="ls -a | grep"
alias search="grep -rnI --color=always"

alias emacs="emacs -nw"
alias mutt="neomutt"

# Load Device-Specific Configuration

local="$HOME/.local_bash_profile"
if [ -f "$local" ]
then
	source "$local"
fi

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="node_modules/.bin:$PATH"
