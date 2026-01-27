#!/bin/bash
# macOS Settings Restore Script
# Generated: 2026-01-27

echo "Restoring macOS settings..."

# === Dock ===
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 67

# === Finder ===
defaults write com.apple.finder AppleShowAllExtensions -bool true
defaults write com.apple.finder CreateDesktop -bool false  # Hide desktop icons

# === Global ===
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false  # Enable key repeat
defaults write NSGlobalDomain KeyRepeat -int 2  # Fast key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15  # Short delay

# === Window Manager ===
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# === Keyboard Shortcuts ===
# Disable Spotlight (for Raycast)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

# Disable Screenshots (for CleanShot) - Cmd+Shift+3/4/5
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 29 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 "<dict><key>enabled</key><false/></dict>"

# Disable Mission Control / Spaces shortcuts (for tmux/nvim)
for i in 15 16 17 18 19 20 21 22 23 24 25 26; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add $i "<dict><key>enabled</key><false/></dict>"
done

# Disable other conflicting shortcuts
for i in 33 34 52 60 61 65 79 80 81 82 118 119 184; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add $i "<dict><key>enabled</key><false/></dict>"
done

echo "Restarting affected services..."
killall Dock
killall Finder
killall SystemUIServer

echo ""
echo "Done! Some changes may require logout/restart."
echo ""
echo "NOTE: For full keyboard shortcut restore, you can also copy:"
echo "  symbolichotkeys-backup.plist -> ~/Library/Preferences/com.apple.symbolichotkeys.plist"
echo "  Then log out and back in."
