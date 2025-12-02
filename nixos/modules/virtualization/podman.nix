{ config, pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # pour faire `podman` comme si c’était docker
  };
  # Eventuellement :
  virtualisation.containers.enable = true;
}
