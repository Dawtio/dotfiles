#!/bin/bash

# Update stores
sudo dnf update

# Install package
sudo dnf install g++ -y # dependency for neovim plugins

./install-core.sh
