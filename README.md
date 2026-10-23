# dotfiles

macOS (Apple Silicon) + zsh + sheldon + Powerlevel10k + Ghostty

## Install

    curl -fsSL https://raw.githubusercontent.com/yuyu33/dotfiles/master/install.sh | bash

## GitHub multi-account

    gh auth login        # login each account once
    ghsw                 # list accounts
    ghp / ghw            # switch to personal / work account
    ghsw yuyu33 -l       # switch + set repo author
    ghas yuyu33 git push # run one command as yuyu33

## Local (untracked)

- ~/.config/zsh/.zshrc.local
- ~/.config/git/config.local
