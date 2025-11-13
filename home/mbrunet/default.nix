{ config, pkgs, inputs, ... }:

{
  home.username = "mbrunet";
  home.homeDirectory = "/home/mbrunet";
  home.stateVersion = "25.05";

  imports = [
    ./packages.nix
    ./config_mappers.nix
  ];

  programs.home-manager.enable = true;
}
