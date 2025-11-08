{ modulesPath, config, pkgs, inputs, ... }:

{
  imports = [
    ./amazon-image.nix
    ../../modules/common.nix
    ../../modules/windowManager/xfce.nix
  ];

  networking.hostName = "aws";

  users.users.mbrunet = {
    isNormalUser = true;
    description = "mbrunet";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mbrunet = import ../../home/mbrunet/default.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}
