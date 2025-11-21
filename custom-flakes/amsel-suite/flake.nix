{
  description = "A flake for packaging Amsel Suite from Ollam Technologies";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      # Define the system we're building for
      system = "x86_64-linux";
      # Import nixpkgs and allow unfree packages for this flake
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      # --- Dependency List ---
      appRuntimeDependencies = with pkgs; [
        alsa-lib
        at-spi2-atk
        at-spi2-core
        cairo
        cups
        dbus
        expat
        gdk-pixbuf
        glib
        zenity
        gsettings-desktop-schemas
        gtk3
        libayatana-appindicator
        libdrm
        libGL
        libglvnd
        libgbm
        libnotify
        libappindicator-gtk3
        libsecret
        libxkbcommon
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXrandr
        xorg.libXtst
        xorg.libxcb
        mesa
        nspr
        nss
        pango
        pipewire
        polkit
        systemd
        udev
        vips
        wayland
        xorg.libxshmfence
      ];
    in
    {
      packages.${system} = {
        # --- Amsel Suite Unwrapped Package ---
        amsel-suite-unwrapped = pkgs.stdenv.mkDerivation rec {
          pname = "amsel-suite-unwrapped";
          version = "1.6.3";
          src = pkgs.fetchurl {
            url = "https://github.com/OllamTechnologies/launcher-releases/releases/download/v${version}/amsel-suite_${version}_amd64.deb";
            sha256 = "976c961b012246d7fa026942ae7426ac88431df6a72b00468401a36e196909b8";
          };
          nativeBuildInputs = [ pkgs.binutils pkgs.xz pkgs.zstd ];
          unpackPhase = ''
            ar x $src
            data_tarball=$(find . -name 'data.tar.*' -print -quit)
            tar -xf "$data_tarball"
          '';
          installPhase = ''
            mkdir -p $out/
            cp -r usr/* $out/
          '';
          meta = { platforms = pkgs.lib.platforms.linux; };
        };

        # --- Amsel Suite FHS Wrapper ---
        amsel-suite =
          let
            # Create a more intelligent fake "pkexec" that executes the command
            # passed to it, but as the current user.
            pkexec-shim = pkgs.writeShellScriptBin "pkexec" ''
              #!/bin/sh
              # Log the intercepted call for debugging.
              echo "[pkexec-shim] Intercepted call, executing as current user: $*" >> /tmp/amsel-shim.log
              # Execute the command passed to pkexec directly.
              # This bypasses the need for privilege escalation and should satisfy the app.
              exec "$@"
            '';
          in
          pkgs.buildFHSEnvBubblewrap {
            pname = "amsel-suite";
            version = "1.5.5";
            # We add our shim to the build so we can access its path for the mount.
            targetPkgs = pkgs: appRuntimeDependencies ++ [ pkexec-shim self.packages.${system}.amsel-suite-unwrapped ];

            runScript = pkgs.writeShellScript "amsel-suite-launcher" ''
              #!${pkgs.bash}/bin/bash
              # Create the persistent directory for downloaded applications.
              mkdir -p "$HOME/.local/share/ollam-suite/opt"
              exec "/usr/lib/amsel-suite/Amsel Suite" "$@"
            '';

            extraGroups = [ "video" "input" ];

            extraMounts = [
              # Provide persistent, writable storage for downloaded apps.
              {
                source = "$HOME/.local/share/ollam-suite/opt";
                target = "/opt";
                writable = true;
              }
              # --- The Crucial Fix ---
              # Mount our fake pkexec script directly over the real one in the sandbox.
              # This intercepts the call even if the app uses a hardcoded path.
              {
                source = "${pkexec-shim}/bin/pkexec";
                target = "/usr/bin/pkexec";
              }
            ];

            meta = with pkgs.lib; {
              description = "The official Amsel Suite by Ollam Technologies (FHS)";
              homepage = "https://github.com/OllamTechnologies/launcher-releases";
              license = licenses.unfree;
              platforms = platforms.linux;
              maintainers = [ maintainers.your-github-username ];
            };
          };

        default = self.packages.${system}.amsel-suite;
      };

      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ self.packages.${system}.amsel-suite ];
        packages = with pkgs; [ patchelf ];
      };
    };
}
