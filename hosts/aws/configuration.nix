{ modulesPath, config, pkgs, inputs, ... }:

{
  imports = [
    ./amazon-image.nix
    ../../modules/common.nix
  ];

  networking.hostName = "x1c13";

  users.users.mbrunet = {
    isNormalUser = true;
    description = "mbrunet";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mbrunet = import ../../home/mbrunet/default.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}
