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
setopt hist_ignore_space no_beep

# ---- completion ----
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
bindkey -M menuselect '^[[Z' reverse-menu-complete

# ---- history search (prefix match with up/down) ----
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# ---- plugins (sheldon) ----
(( $+commands[sheldon] )) && eval "$(sheldon source)"

# ---- tools ----
(( $+commands[mise]   )) && eval "$(mise activate zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[fzf]    )) && source <(fzf --zsh)

# ---- aliases ----
if (( $+commands[eza] )); then
  alias ls='eza --icons=auto' ll='eza -la --icons=auto --git' lt='eza -T --icons=auto -L 2'
fi
(( $+commands[bat] )) && alias cat='bat -pp'
alias g='git' gs='git status' gd='git diff' gl='git log --oneline --graph -20'

# ---- GitHub multi-account ----
[[ -f $ZDOTDIR/gh-account.zsh ]] && source "$ZDOTDIR/gh-account.zsh"

# ---- local (git 管理外) ----
[[ -f $ZDOTDIR/.zshrc.local ]] && source "$ZDOTDIR/.zshrc.local"
[[ -f $ZDOTDIR/.p10k.zsh ]] && source "$ZDOTDIR/.p10k.zsh"
