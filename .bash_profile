# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
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

export PS1="\n\[\e[36m\][\[\e[m\]\[\e[36m\]\W\[\e[m\]\[\e[36m\]]\[\e[m\]\[\e[34m\]\`parse_git_branch\`\[\e[m\]\\$ "

# Default text editor
export VISUAL=vim
export EDITOR="$VISUAL"
set -o vi

# Aliases
# alias dir="ls -lah"
alias search="grep -rnI --color=always"
alias tm="tmux -2 attach -t"
alias dc="docker-compose"
alias vim="/usr/local/Cellar/vim/8.0.1400_4/bin/vim"
alias lc="colorls "
alias dir="colorls -1A"

alias composer="php /usr/local/bin/composer.phar"

# Wiki
function wikiSearch() {
  grep -rni --color="always" "$1" ~/Documents/wiki
}
alias ws="wikiSearch"

# Misc Tweaks
export CLICOLOR=YES
source ~/.git-completion.bash
source ~/.git-prompt.sh
bind Space:magic-space

source $(dirname $(gem which colorls))/tab_complete.sh

# Temp Env Variables
export BB_USER="zstickles"
export BB_PASS="Interpol7a"
