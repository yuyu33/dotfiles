# Powerlevel10k instant prompt（先頭に置く）
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- history ----
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=100000; SAVEHIST=100000
setopt share_history hist_ignore_all_dups hist_reduce_blanks extended_history
setopt auto_cd auto_pushd pushd_ignore_dups interactive_comments

# ---- plugins (sheldon) ----
(( $+commands[sheldon] )) && eval "$(sheldon source)"

# ---- tools ----
(( $+commands[pyenv]  )) && eval "$(pyenv init - zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[fzf]    )) && source <(fzf --zsh)

# ---- aliases ----
if (( $+commands[eza] )); then
  alias ls='eza --icons' ll='eza -la --icons --git' lt='eza -T --icons -L 2'
fi
(( $+commands[bat] )) && alias cat='bat -pp'
alias g='git' gs='git status' gd='git diff' gl='git log --oneline --graph -20'

# ---- GitHub multi-account ----
[[ -f $ZDOTDIR/gh-account.zsh ]] && source "$ZDOTDIR/gh-account.zsh"

# ---- local (git 管理外) ----
[[ -f $ZDOTDIR/.zshrc.local ]] && source "$ZDOTDIR/.zshrc.local"
[[ -f $ZDOTDIR/.p10k.zsh ]] && source "$ZDOTDIR/.p10k.zsh"
