# Default text editor
export VISUAL=vim
export EDITOR="$VISUAL"
set -o vi

# Aliases
alias dir="ls -lah"
alias tm="tmux attach -t"
alias search="grep -rn --color=always"

# Promptline
source ~/.shell_prompt.sh

# Misc Tweaks
export CLICOLOR=YES
# source ~/.git-completion.bash
