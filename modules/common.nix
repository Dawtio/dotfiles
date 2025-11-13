# modules/common.nix
{ config, pkgs, ... }:

{
  # --- System-level defaults shared across hosts ---
  system.stateVersion = "25.05";

  # Allow unfree packages to be installed.
  nixpkgs.config.allowUnfree = true;

  # Locales et timezone par défaut (tu peux les override dans hosts/* si besoin)
  time.timeZone = "Europe/Paris";

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
    brightnessctl
  ];

  # Activer zsh globalement (utile si plusieurs users)
  programs.zsh.enable = true;

  # Allow Lazyvim to manage its own dependencies installation;
  programs.nix-ld.enable = true;

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
    nerd-fonts.jetbrains-mono
  ];

}
