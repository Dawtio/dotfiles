{ config, pkgs, ... }:

{
  services.xrdp = {
    enable = true;
    openFirewall = true;
    defaultWindowManager = "startxfce4";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
  };
}
