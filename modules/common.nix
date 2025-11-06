# modules/common.nix
{ config, pkgs, ... }:

{
  # --- System-level defaults shared across hosts ---

  # Allow unfree packages to be installed.
  nixpkgs.config.allowUnfree = true;

  # Locales et timezone par défaut (tu peux les override dans hosts/* si besoin)
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.supportedLocales = [ "fr_FR.UTF-8" "en_US.UTF-8" ];

  # Console (utile si tu es en TTY)
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # Paquets disponibles sur toutes les machines
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    htop
    unzip
    zip
    pciutils
    usbutils
  ];

  # Activer zsh globalement (utile si plusieurs users)
  programs.zsh.enable = true;

  # Nix configuration globale
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    warn-dirty = false;
  };

  # Journalisation / logrotate de base
  services.journald.extraConfig = ''
    SystemMaxUse=1G
  '';

  # Clean / tmp au boot
  boot.tmp.cleanOnBoot = true;

  # Security / sudo de base
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Fonts (pour wezterm, neovim, etc.)
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

}
