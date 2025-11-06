{ config, pkgs, ... }:
{
  programs.zsh.enable = true;

  # symlink Zsh;
  home.file.".config/zsh".source = ../../zsh;
  home.file.".zshrc".source = ../../zsh/.zshrc;

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ../../.wezterm.lua;
  };

}
