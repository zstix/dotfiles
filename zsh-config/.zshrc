DOTFILES="$HOME/dotfiles"

# Default text editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Oh My ZSH
export ZSH="$DOTFILES/zsh-config/.oh-my.zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Aliases
alias dir="ls -lah"
alias t="task"
