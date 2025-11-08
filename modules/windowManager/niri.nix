{ config, pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    wayland
    wl-clipboard
    grim
    slurp
    wofi
    # pour écrans OLED / luminosité
    brightnessctl
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
