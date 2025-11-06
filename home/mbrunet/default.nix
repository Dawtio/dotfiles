{ config, pkgs, inputs, ... }:

{
  home.username = "mbrunet";
  home.homeDirectory = "/home/mbrunet";

  imports = [
    ./terminal.nix
    ./editors.nix
    ./desktop.nix
  ];

  programs.home-manager.enable = true;
}
