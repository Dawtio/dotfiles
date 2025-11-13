{ config, pkgs, ... }:


let
    dotfiles = "${config.home.homeDirectory}/dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    # Standard .config/directory
    configs = {
      nvim = "nvim";
      hypr = "hypr";
      waybar = "waybar";
      zsh = "zsh";
    };
in

{

  # Iterate over xdg configs and map them accordingly
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  # Using home.file for specific file.
  home.file.".zshrc" = {
    source = ../../config/zsh/.zshrc;
    force = true;
  };

}
