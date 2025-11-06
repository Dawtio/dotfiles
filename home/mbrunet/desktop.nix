{ config, pkgs, ... }:
{

  # Install user packages.
  home.packages = with pkgs; [
    arc-browser
    firefox
    wl-clipboard
  ];

  # symlink Niri;
  home.file.".config/niri/config.kdl".source = ../../niri/config.kdl;

}
