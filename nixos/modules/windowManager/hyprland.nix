{ config, pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    kitty
    xfce.thunar
    rofi
    waybar
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "mbrunet";
      };
    };
  };

  # Force using Wayland for Electron application. (i.e Discord)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

}
