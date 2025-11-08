{ config, pkgs, ... }:
{

  # Install user packages.
  home.packages = with pkgs; [
    # GUI
    firefox
    wl-clipboard
    # Shell global
    gcc
    gnumake
    pkg-config
    direnv
    zoxide
    eza
    tlrc
    bat
    jq
    yq
    fzf
    fd
    # Development tools
    nodejs
    lazygit
    commitizen
    pre-commit
    # Formatting tools
    stylua
    libxml2
    yamlfmt
    terraform-docs
    kube-linter
    kubeconform
  ];

  # symlink Niri;
  home.file.".config/niri/config.kdl".source = ../../config/niri/config.kdl;

}
