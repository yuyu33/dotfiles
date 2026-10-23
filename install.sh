#!/usr/bin/env bash
# Usage: curl -fsSL https://raw.githubusercontent.com/yuyu33/dotfiles/master/install.sh | bash
set -euo pipefail
REPO="https://github.com/yuyu33/dotfiles.git"
DOT="${DOTFILES:-$HOME/dotfiles}"

# 1. Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  read -rp "Press Enter after CLT install finishes: " </dev/tty
fi

# 2. Homebrew
if [[ ! -x /opt/homebrew/bin/brew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. clone / pull
if [[ -d $DOT/.git ]]; then git -C "$DOT" pull --ff-only || true; else git clone "$REPO" "$DOT"; fi

# 4. packages
brew bundle --file="$DOT/Brewfile"

# 5. symlinks (backup existing real files)
link() {
  local src=$1 dst=$2
  mkdir -p "$(dirname "$dst")"
  if [[ -e $dst && ! -L $dst ]]; then mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"; fi
  ln -sfn "$src" "$dst" && echo "linked: $dst"
}
link "$DOT/zsh/.zshenv" "$HOME/.zshenv"
for f in .zprofile .zshrc .p10k.zsh gh-account.zsh; do link "$DOT/zsh/$f" "$HOME/.config/zsh/$f"; done
for d in "$DOT"/config/*/; do link "${d%/}" "$HOME/.config/$(basename "$d")"; done
link "$DOT/bin/dot" "$HOME/.local/bin/dot"
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
link "$DOT/ssh/config" "$HOME/.ssh/config"
link "$DOT/ssh/github-yuyu33.pub" "$HOME/.ssh/github-yuyu33.pub"
# 1Password SSH agent socket (path without spaces)
OPSOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
mkdir -p "$HOME/.1password" && ln -sfn "$OPSOCK" "$HOME/.1password/agent.sock"

# 6. local overrides (untracked)
touch "$HOME/.config/zsh/.zshrc.local" "$HOME/.config/git/config.local" "$HOME/.ssh/config.local"

# 7. zsh plugins
sheldon lock --update

# 8. runtimes (mise)
mise install

# 9. macOS defaults (skip with SKIP_MACOS=1)
[[ ${SKIP_MACOS:-0} == 1 ]] || "$DOT/macos.sh"

echo "Done. Restart your terminal."
