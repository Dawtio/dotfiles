{ config, pkgs, ... }:
{
  programs.zsh.enable = true;

  # symlink Zsh;
  home.file.".config/zsh/.p10k.zsh".source = ../../config/zsh/.p10k.zsh;
  home.file.".config/zsh/antigen.zsh".source = ../../config/zsh/antigen.zsh;
  home.file.".zshrc".source = ../../config/zsh/.zshrc;

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ../../config/.wezterm.lua;
  };

}
