{ config, pkgs, inputs, ... }:
{

  # Install user packages.
  home.packages = with pkgs; [
    # GUI
    inputs.zen-browser.packages.${pkgs.system}.zen-browser # Internet browser
    wl-clipboard                                           # Copy paste a useful function.
    obsidian                                               # THE documentation tools.
    vesktop                                                # Discord client
    _1password-gui                                         # Password Manager
    thunderbird                                            # Mailing client
    inputs.awww.packages.${pkgs.system}.awww               # Wallpaper tool
    nwg-look                                               # Handle Theme for GTK apps
    # gtk3
    # gtk4
    # graphite-gtk-theme
    # glib
    hyprlock                                               # logout tools
    wlogout                                                # logout/shutdown/reboot gui
    grim                                                   # Make a screenshot
    slurp                                                  # Get coordonates for screenshot
    swaynotificationcenter                                 # Notification center
    xournalpp                                              # Handle hand-writing and PDF signing.
    spotify                                                # Things are always good with music.
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
    fastfetch
    matugen
    libnotify
    distrobox
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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # programs.spicetify = let
  #   spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  # in {
  #   enable = true;
  #   theme = spicePkgs.themes.catppuccin;
  # };
}
