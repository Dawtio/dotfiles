{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/windowManager/hyprland.nix
  ];

  networking.hostName = "x1c13";

  users.users.mbrunet = {
    isNormalUser = true;
    description = "mbrunet";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
  networking.wireless.iwd.enable = true;

  services.upower.enable = true;

  # Digital Footprint
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;

  # Webcam
  hardware.ipu6 = {
    enable = true;
    platform = "ipu6epmtl"; # pour ThinkPad X1 gen 13 (Intel BE)
  };

  hardware.graphics.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Portals pour Discord/Firefox
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.icamerasrc-ipu6epmtl
    ipu6epmtl-camera-hal
    v4l-utils      # v4l2-ctl, utile pour debug
    libcamera
    cheese         # pour tester la webcam via PipeWire
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mbrunet = import ../../home/mbrunet/default.nix;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
  };

}
