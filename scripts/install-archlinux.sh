#!/bin/sh

# PREREQUISITES
# - use `iwctl` to connect on wifi network.
# - check working internet connection with `ping 1.1.1.1`
#

post_install() {
  sudo pacman -S --needed git curl neovim reflector

  # backup mirrorlist.
  sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  # generate new one with chaotic.
  sudo reflector --save /etc/pacman.d/mirrorlist --sort rate --sort age --country "France" --country "Worldwide"
  # set AUR helper.
  git clone https://aur.archlinux.org/yay-bin
  cd yay-bin/
  makepkg -si
  cd ../
  rm -rf yay-bin/

  # Setup Chaotic AUR.
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf

  # System update
  sudo pacman -Syu
}

main() {
  # Basic windows manager.
  yay -S --needed kitty hyprland gtk4 rofi waybar swaync grim slurp wlogout
  # Basic packages
  yay -S --needed brightnessctl hyprlock playerctl polkit-gnome wl-clipboard xdg-desktop-portal-hyprland xdg-desktop-portal-gtk usbutils fprintd openssh
  # Theming packages
  yay -S --needed nwg-look awww ttf-jetbrains-mono-nerd papirus-icon-theme papirus-folder
  # Shell packages
  yay -S --needed zsh direnv zoxide eza bat fzf fd lazygit fastfetch unzip jq yq
  # Format packages
  yay -S --needed pre-commit stylua libxml2 yamlfmt commitizen
  # GUI packages
  yay -S --needed 1password zen-browser meson cpio cmake obsidian thunderbird vesktop thunar spotify
  # Webcam stuff
  yay -S --needed v4l-utils libcamera libcamera-tools libcamera-ipa pipewire-libcamera gst-plugin-libcamera
  # Custom install.
  curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
  sudo chmod a+wr /opt/spotify
  sudo chmod a+wr /opt/spotify/Apps -R
}

init_config() {
  cp -r projects/dotfiles/themes .themes

  cp -r config/hypr/* ~/.config/hypr/
  cp -r config/zsh/ ~/.config/
  cp -r config/nvim/ ~/.config/
  cp -r config/colorschemes/ ~/.config/
  cp -r config/gtk-* ~/.config/
  cp -r config/kitty/ ~/.config/
  cp -r config/rofi/ ~/.config/
  cp -r config/swaync/ ~/.config/
  cp -r config/vesktop/ ~/.config/
  cp -r config/waybar/ ~/.config/
  cp -r config/wlogout/ ~/.config/
}

main
