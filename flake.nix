{
  description = "NixOS + Home Manager for Lenovo ThinkPad X1 Carbon Gen 13 (Arrow Lake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:Eviato/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    zen-browser = {
      url = "path:./custom-flakes/zen-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    amsel-suite = {
      url = "path:./custom-flakes/amsel-suite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    awww.url = "git+https://codeberg.org/LGFae/awww";

  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, niri, hyprland, zen-browser, amsel-suite, ... } @ inputs : {
      nixosConfigurations = {
        x1c13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen-arrow
            ./hosts/x1c13/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = { inherit inputs self nixpkgs home-manager hyprland zen-browser amsel-suite; };
        };
        aws = nixpkgs.lib.nixosSystem {
          system = "x64_86-linux";
          modules = [
            ./hosts/aws/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = { inherit self nixpkgs home-manager; };
        };
      };
    };
}
