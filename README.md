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

## Commands

    dot update           # pull + brew bundle + mise install + sheldon update
    dot dump             # list packages not in Brewfile
    ./macos.sh           # apply macOS defaults (install.sh runs it; SKIP_MACOS=1 to skip)

## Runtimes

Managed by mise: ~/.config/mise/config.toml (python / terraform / node)

## SSH

Keys live in 1Password. Enable: 1Password > Settings > Developer > Use the SSH agent.
Per-machine hosts go in ~/.ssh/config.local.
