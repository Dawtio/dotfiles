{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/windowManager/hyprland.nix
    ../../modules/virtualization/podman.nix
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

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  security.polkit = {
    enable = true;
    extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    });
    '';
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Digital Footprint
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # # Webcam
  # hardware.ipu6 = {
  #   enable = true;
  #   platform = "ipu6epmtl"; # pour ThinkPad X1 gen 13 (Intel BE)
  # };
  #
  # hardware.graphics.enable = true;
  #
  # # Portals pour Discord/Firefox
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
  #
  # environment.systemPackages = with pkgs; [
  #   gst_all_1.gstreamer
  #   gst_all_1.gst-plugins-base
  #   gst_all_1.gst-plugins-good
  #   gst_all_1.gst-plugins-bad
  #   gst_all_1.gst-plugins-ugly
  #   gst_all_1.icamerasrc-ipu6epmtl
  #   ipu6epmtl-camera-hal
  #   v4l-utils      # v4l2-ctl, utile pour debug
  #   libcamera
  #   cheese         # pour tester la webcam via PipeWire
  # ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mbrunet = import ../../home/mbrunet/default.nix;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
  };

}
