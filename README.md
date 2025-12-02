<h1 align="center">💻 Dawtio Dotfiles</h1>
<p align="center">
  <i>Modern, modular, Wayland-native dotfiles for Arch Linux (Hyprland)</i>
</p>

<p align="center">
  <!-- OS & Desktop -->
  <img alt="arch" src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white"/>
  <img alt="ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white"/>
  <img alt="nixos" src="https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white"/>
  <img alt="macos" src="https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white"/>
</p>

<p align="center">
  <!-- Tools -->
  <img alt="hyprland" src="https://img.shields.io/badge/Hyprland-00A1E0?style=for-the-badge&logo=hyprland&logoColor=white"/>
  <img alt="wayland" src="https://img.shields.io/badge/Wayland-34BE5B?style=for-the-badge&logo=wayland&logoColor=white"/>
  <img alt="nvim" src="https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white"/>
  <img alt="kitty" src="https://img.shields.io/badge/Kitty-32C854?style=for-the-badge&logo=kitty&logoColor=white"/>
  <img alt="zsh" src="https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logo=gnu-bash&logoColor=white"/>
  <img alt="rofi" src="https://img.shields.io/badge/Rofi-1D1F21?style=for-the-badge"/>
</p>

<p align="center">
  <a href="LICENSE">
    <img alt="license" src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge"/>
  </a>
  <img alt="last" src="https://img.shields.io/github/last-commit/Dawtio/dotfiles?style=for-the-badge"/>
</p>

---

## 🖼️ Desktop Preview

> _(Screenshot placeholder – replace with your own)_  
> <img alt="" src="./screenshot.png" />

---

## 🎞️ Quick Overview (GIF Placeholder)

> _(Replace with your own GIF showing Hyprland_
> _animations, themes, switching wallpapers, etc.)_
> <img alt="" src="./preview.gif" />

---

## ✨ Features

### 🪟 Wayland + Hyprland

- Active tiling with animations
- Smooth workspace navigation
- Waybar with dynamic theming
- Rofi launcher with automatic palette updates
- Native Wayland apps everywhere

### 🎨 Dynamic System-Wide Theming

- Standard theme (Catppcuccin / Kanagawage / ... )
- Auto-applies:
  - Waybar CSS
  - GTK3 + GTK4 theme
  - Terminal colors
  - Rofi theme
  - Hyprland borders / accent color
  - Lock screen
  - Spotify
  - Zen Browser

### 🧑‍💻 Dev Environment Ready

- LazyVim (Neovim distribution)
- Treesitter
- LSP preconfigured
- Kitty terminal
- Zsh with plugins & autosuggestions
- Git config
- Fast shortcuts + aliases

### 🧃 Multi-OS Support

This project aims to be OS agnostics as much as possible.

---

## 📜 Philosophy

> **“A dotfiles repo should be declarative, modular and fun.”**

- 🔹 No monolithic configs
- 🔹 Keep things readable
- 🔹 No weird hacks or magic files
- 🔹 Anyone can clone & adapt
- 🔹 Everything is DRY (Don’t Repeat Yourself)
- 🔹 1-command setup possible

This repo evolves as my workflow evolves.

---

## 📁 Project Structure (under construction)

```bash
dotfiles/
├── arch/
│ ├── install.sh # Bootstrap Arch setup
│ ├── packages.txt # Pacman packages
│ ├── aur-packages.txt # AUR packages
│ ├── post-install.sh # Optional polish
│ └── README.md
│
├── config/
│ ├── hypr/ # Hyprland configs
│ ├── waybar/ # Waybar
│ ├── kitty/ # Terminal
│ ├── nvim/ # LazyVim
│ ├── rofi/ # Launcher
│ └── ...
│
├── scripts/
│ ├── theme/ # Auto-theming pipeline
│ ├── system/ # Maintenance tools
│ ├── mac/ # macOS helpers
│ └── ...
│
├── zsh/
│ ├── .zshrc
│ ├── aliases.zsh
│ ├── exports.zsh
│ ├── plugins.zsh
│ └── ...
│
├── bootstrap.sh # Full auto-installer
└── LICENSE
```

---

## 🔧 Requirements

Before using these dotfiles:

### On any Linux distro

- Internet access
- `git` installed
- Wayland-compatible hardware drivers

### On MacOS

- Internet access
- Developers tools installed
- `git` installed

---

# 🎨 Theming Commands

| Command         | Description                         |
| --------------- | ----------------------------------- |
| SUPER+(SHIFT)+T | Change wallpaper + regenerate theme |

# 🤝 Contributing

You can propose:

- New themes
- Hyprland tweaks
- Performance improvements
- Better scripts
- Cross-platform additions

# 📜 License

This project is under the MIT License.
See the LICENSE
file for more details.
