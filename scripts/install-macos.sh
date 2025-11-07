#!/bin/bash

./install-core.sh

# Install GUI package
## Hobbies tool
brew install --cask spotify
brew install --cask calibre
brew install --cask iina
## Minimal setup
brew install --cask wezterm
brew install --cask arc
brew install --cask font-meslo-lg-nerd-font
brew install --cask 1password
brew install --cask fantastical
brew install --cask paragon-ntfs
## Extended setup
brew install --cask obsidian
brew install --cask docker
brew install --cask discord
brew install --cask remarkable
brew install --cask spectacle
brew install --cask raycast

# Copy terminal emulator configuration
cp config/wezterm/.wezterm.lua ~/
