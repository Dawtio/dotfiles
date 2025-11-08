{
  description = "NixOS + Home Manager for Lenovo ThinkPad X1 Carbon Gen 13 (Arrow Lake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, niri, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      x1c13 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # nixos-hardware.nixosModules.lenovo-thinkpad-x1-carbon-gen13
          ./hosts/x1c13/configuration.nix
          home-manager.nixosModules.home-manager
          niri.nixosModules.niri
        ];
        specialArgs = { inherit self nixpkgs home-manager niri; };
      };
      aws = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/aws/configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit self nixpkgs home-manager; };
      };
    };
  };
}
