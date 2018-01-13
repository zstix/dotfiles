# Default text editor
export VISUAL=vim
export EDITOR="$VISUAL"
set -o vi

# Aliases
alias dir="ls -lah"
alias tm="tmux attach -t"
alias search="grep -rn --color=always"

# Wiki
function wikiSearch() {
  grep -rn --color="always" "$1" ~/Documents/wiki
}
alias ws="wikiSearch"

# Promptline / PS1
source ~/.shell_prompt.sh

# Misc Tweaks
export CLICOLOR=YES
source ~/.git-completion.bash
source ~/.git-prompt.sh
