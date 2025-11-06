{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # symlink LazyVim;
  home.file.".config/nvim".source = ../../nvim;
}
