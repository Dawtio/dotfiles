{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # symlink LazyVim;
  home.file.".config/nvim".source = ../../config/nvim;
  home.file.".config/nvim/lazy-lock.json".text = ''
    {} # empty file, let Neovim fill it.
  '';
}
