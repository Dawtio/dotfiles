{ config, pkgs, inputs, ... }:

{
  home.username = "mbrunet";
  home.homeDirectory = "/home/mbrunet";
  home.stateVersion = "25.05";

  imports = [
    ./terminal.nix
    ./editors.nix
    ./desktop.nix
  ];

  programs.home-manager.enable = true;
}
