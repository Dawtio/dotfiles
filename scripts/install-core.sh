#!/bin/bash

# Install brew as package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install CLI package
## Shell tool
brew install zsh direnv zoxide thefuck eza tlrc bat jq yq fzf fd
## Development tool
brew install neovim node lazygit commitizen pre-commit
## Formatting tool
brew install stylua libxml2 yamlfmt terraform-docs kube-linter kubeconform
## Cloud tool
brew install warrensbox/tap/tfswitch
brew install tfswitch openshift-cli kubernetes-cli helm azure-cli
# Install latest Terraform version
tfswitch -u

# Configure nvim
mkdir -p ~/.config/
cp -r ../config/nvim ~/.config/

# Configure zsh
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
cp -v ../config/zsh/* ~/
cp -v ../config/zsh/.* ~/
