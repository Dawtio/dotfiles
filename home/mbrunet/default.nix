{ config, pkgs, inputs, ... }:

{
  home.username = "mbrunet";
  home.homeDirectory = "/home/mbrunet";
  home.stateVersion = "25.05";

  imports = [
    ./packages.nix
    ./config_mappers.nix
    ./hyprland-hm.nix
  ];

  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    # ...
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
      # ...
    ];
  };
}
