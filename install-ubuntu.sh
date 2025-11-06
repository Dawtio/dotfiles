#!/bin/bash

# Update stores
sudo apt update

# Install package
sudo apt install g++ -y # dependency for neovim plugins

./install-core.sh
