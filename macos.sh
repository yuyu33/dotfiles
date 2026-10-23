#!/usr/bin/env bash
# macOS defaults. Re-runnable. Usage: ./macos.sh
set -euo pipefail

# keyboard: fast key repeat, no press-and-hold popup
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

# finder: show hidden files, extensions, path bar
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# screenshots -> ~/Pictures/Screenshots, png, no shadow
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture type -string png
defaults write com.apple.screencapture disable-shadow -bool true

# dock: autohide, no recent apps
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

killall Finder Dock SystemUIServer 2>/dev/null || true
echo "macOS defaults applied (some need logout to take effect)."
