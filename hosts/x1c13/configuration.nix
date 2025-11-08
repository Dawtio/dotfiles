{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/windowManager/niri.nix
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

  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = "mbrunet";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mbrunet = import ../../home/mbrunet/default.nix;
    extraSpecialArgs = { inherit inputs; };
  };

}
