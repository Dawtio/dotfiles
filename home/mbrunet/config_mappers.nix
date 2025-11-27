{ config, pkgs, ... }:


let
    dotfiles = "${config.home.homeDirectory}/dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    # Standard .config/directory
    configs = {
      nvim = "nvim";
      waybar = "waybar";
      zsh = "zsh";
      kitty = "kitty";
      matugen = "matugen";
      "gtk-3.0" = "gtk-3.0";
      "gtk-4.0" = "gtk-4.0";
      rofi = "rofi";
      wlogout = "wlogout";
      swaync = "swaync";
      vesktop = "vesktop";
      colorschemes = "colorschemes";
      "hypr/colors" = "hypr/colors";
      "hypr/hyprlock" = "hypr/hyprlock";
      spicetify = "spicetify";
    };
in

{

  # Iterate over xdg configs and map them accordingly
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.file.".themes" = {
    source = create_symlink "${dotfiles}/../themes";
    recursive = true;
  };

  # Using home.file for specific file.
  home.file.".zshrc" = {
    source = ../../config/zsh/.zshrc;
    force = true;
  };

}
