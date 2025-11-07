# 🧰 dotfiles

[![NixOS](https://img.shields.io/badge/NixOS-Flake-5277C3?logo=nixos&logoColor=white)](https://nixos.org)
[![Home Manager](https://img.shields.io/badge/Home_Manager-Declarative-blue?logo=nixos&logoColor=white)](https://nix-community.github.io/home-manager/)
[![MacOS](https://img.shields.io/badge/macOS-Compatible-black?logo=apple)]()
[![Ubuntu](https://img.shields.io/badge/Ubuntu-Compatible-E95420?logo=ubuntu&logoColor=white)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

> Personal, reproducible and cross-platform environment configuration  
> ⚙️ Powered by **NixOS**, **Home Manager**, and traditional dotfiles (macOS / Linux)

---

## 🎯 Purpose

This repository contains all my system and user configuration files — unified under a single, declarative setup.

The goal is to:

- Keep **my entire environment reproducible** across machines (NixOS, MacOS, Ubuntu)
- Maintain a **clean and modular structure** for long-term maintainability
- Use **symlinks** to keep editing workflows simple and direct
- Support both **modern NixOS flakes** and **classic shell-based installs**

| Platform             | Supported | Notes                                |
| -------------------- | --------- | ------------------------------------ |
| 🐧 **NixOS**         | ✅        | Main environment (Arrow Lake / Niri) |
| 🍎 **MacOS**         | ✅        | Homebrew + install script            |
| 🐧 **Ubuntu/RedHat** | ✅        | apt/dnf + Homebrew + install script  |

---

## 🗂️ Structure Overview

```sh
dotfiles/
├── flake.nix                        # Entry point for NixOS + Home Manager (flakes)
│
├── hosts/                       # Machine-specific system configurations
│   └── x1c13/
│       ├── configuration.nix        # Main NixOS config for Lenovo X1 Carbon Gen 13
│       └── hardware-configuration.nix
│
├── home/                        # Home Manager user configurations
│   └── mbrunet/
│       ├── default.nix              # Home Manager entrypoint
│       ├── terminal.nix             # wezterm + zsh setup
│       ├── editors.nix              # Neovim (LazyVim) configuration
│       └── desktop.nix              # Apps and desktop environment packages
│
├── modules/                     # Modular system-level NixOS configs
│   ├── common.nix
│   ├── wayland/
│   │   └── niri.nix                 # Niri compositor config
│   └── virtualization/
│       └── podman.nix               # Container support
│
├── config/
│   ├── niri/config.kdl              # Wayland compositor config (Niri)
│   ├── nvim/                        # Neovim config (LazyVim)
│   ├── zsh/                         # ZSH configuration files
│   └── wezterm/.wezterm.lua                 # WezTerm terminal config
│
├── scripts/
│   ├── install-core.sh              # Core package lists.
│   ├── install-macos.sh             # Install core + cask brew
│   ├── install-redhat.sh            # Install prerequisites + core
│   └── install-ubuntu.sh            # Install prerequisites + core

```

---

## 💻 macOS / Ubuntu Setup

This repo also includes **scripts for non-Nix systems**.
They’re meant to replicate the environment on machines where Nix is not used.

### MacOS setup

```bash
# Clone the repo
git clone https://github.com/Dawtio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install packages and link configs
./scripts/install-macos.sh
```

That script:

- Installs Homebrew (if not already installed)
- Installs packages defined in brewfile or inline in the script
- Sets up your ZSH + Neovim environment

## Ubuntu / RedHat setup

```zsh
# Clone the repo
git clone https://github.com/Dawtio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install packages and link configs
./scripts/install-(ubuntu|redhat).sh
```

That script:

- Installs packages with apt
- Installs Homebrew (if not already installed)
- Sets up your ZSH + Neovim environment

---

## 🐧 NixOS Installation (Lenovo X1 Carbon Gen 13)

Fully declarative install powered by flakes + Home Manager.

1. Boot from a recent NixOS ISO (unstable channel recommended)

This ensures support for your Arrow Lake CPU and Wi-Fi 7 chipset.

2. Partition & mount disks

```sh
sudo fdisk /dev/nvme0n1
sudo mkfs.btrfs /dev/nvme0n1pX
sudo mount /dev/nvme0n1pX /mnt
```

3. Generate hardware config

```sh
nixos-generate-config --root /mnt
```

Move or copy it into your repo under: `hosts/x1c13/hardware-configuration.nix`

4. Clone your dotfiles and install

```sh
git clone https://github.com/Dawtio/dotfiles.git /mnt/etc/nixos
cd /mnt/etc/nixos
nixos-install --flake .#x1c13
```

5. Reboot 🎉

After reboot, greetd will log into your Wayland session (Niri)
with your full user environment (zsh, wezterm, LazyVim, podman).

---

## 🔐 Secrets & Next Steps

Future plans:

- Integrate agenix or sops-nix for secret management
- Add power management tweaks for ThinkPad (battery thresholds, sleep tuning)
- Version wallpapers, GTK themes, and systemd user services

---

## 🧾 License

MIT — feel free to fork and adapt.

Credits are appreciated ❤️

---

<div align="center">

💻 Made with ❤️ by **mbrunet ([@Dawtio](https://github.com/Dawtio))**  
🧩 Built with [NixOS](https://nixos.org) · [Home Manager](https://nix-community.github.io/home-manager/) · [LazyVim](https://lazyvim.github.io)

</div>
