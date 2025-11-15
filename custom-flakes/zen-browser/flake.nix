{
  description = "Zen Browser packaged from AppImage";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          zen-browser = let
            version = "1.17.6b";
            src = pkgs.fetchurl {
              url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-x86_64.AppImage";
              sha256 = "959aea5a04e006869f8767cf66a5e44198a506f8cdf35242a5012c90387a1fb4";
            };
          in pkgs.appimageTools.wrapType2 {
            inherit src version;
            pname = "zen-browser";

            extraPkgs = pkgs: [
              pkgs.fuse
            ];

            extraInstallCommands = ''
              mkdir -p $out/share/applications

              cat > $out/share/applications/zen-browser.desktop <<EOF
              [Desktop Entry]
              Name=Zen Browser
              Exec=zen-browser %U
              Terminal=false
              Type=Application
              Categories=Network;WebBrowser;
              Icon=zen-browser
              MimeType=text/html;x-scheme-handler/http;x-scheme-handler/https;
              EOF
              '';
          };

          default = self.packages.${system}.zen-browser;
        }
      );

      apps = forAllSystems (system: {
        zen-browser = {
          type = "app";
          program = "${self.packages.${system}.zen-browser}/bin/zen-browser";
        };
        default = self.apps.${system}.zen-browser;
      });
    };
}

