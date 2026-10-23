eval "$(/opt/homebrew/bin/brew shellenv zsh)"
typeset -U path
path=($HOME/bin $HOME/.local/bin $path)
