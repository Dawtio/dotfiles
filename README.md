<h1 align="center">Dawtio Dotfiles</h1>

<p align="center">
  <i>A thin, personal layer on top of <a href="https://omarchy.org">Omarchy</a>. Stock where it's good, tweaked where it matters.</i>
</p>

<p align="center">
  <a href="https://omarchy.org"><img alt="Omarchy" src="https://img.shields.io/badge/Omarchy-4.x-1e1e2e?style=for-the-badge"/></a>
  <a href="https://archlinux.org"><img alt="Arch Linux" src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white"/></a>
  <a href="https://hypr.land"><img alt="Hyprland" src="https://img.shields.io/badge/Hyprland-00A1E0?style=for-the-badge&logo=hyprland&logoColor=white"/></a>
  <a href="https://neovim.io"><img alt="Neovim" src="https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white"/></a>
  <a href="https://starship.rs"><img alt="Starship" src="https://img.shields.io/badge/Starship-DD0B78?style=for-the-badge&logo=starship&logoColor=white"/></a>
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge"/></a>
  <img alt="Last commit" src="https://img.shields.io/github/last-commit/Dawtio/dotfiles?style=for-the-badge"/>
</p>

---

## ✨ Philosophy

Omarchy already ships a polished Hyprland desktop, so this repo does **not** try to rebuild it.
It only tracks the files I've actually changed, and symlinks them over a fresh install.
No framework, no dependencies: one Bash script and a folder tree that mirrors `$HOME`.

## 🧩 What's inside

| Area | Highlights |
|---|---|
| **Hyprland** | Scrolling layout, rounded corners, inactive-window transparency, the "magic" special workspace, app shortcuts (Spotify, Obsidian, 1Password), a three-monitor layout |
| **Omarchy shell** | Vertical bar on the left, custom clock, idle timers, font size |
| **Theming** | Theme-colored window shadows, a Vesktop theme that follows the Omarchy theme, a custom wallpaper, custom branding art |
| **Terminals** | Alacritty, Foot, Ghostty and Kitty all set to Adwaita Mono |
| **Neovim** | A hand-rolled [lazy.nvim](https://github.com/folke/lazy.nvim) config: LSP, blink.cmp, Treesitter, Snacks, [opencode](https://opencode.ai) integration |
| **Shell & tools** | [Starship](https://starship.rs) prompt, [mise](https://mise.jdx.dev) tool versions, Git with GPG signing, opencode |

## 🗂️ Repository structure

```
dotfiles/
├── install.sh          # symlinks everything into place
├── config/             # mirrors ~/.config
│   ├── hypr/           #   bindings, look & feel, monitors, input
│   ├── omarchy/        #   shell.json, themed templates, hooks, branding, backgrounds
│   ├── nvim/           #   full Neovim config (linked as a whole folder)
│   ├── alacritty/ foot/ ghostty/ kitty/
│   ├── fontconfig/ git/ mise/ opencode/ autostart/
│   ├── chromium-flags.conf
│   └── starship.toml
└── home/               # mirrors ~ (e.g. .bashrc)
```

The rule is simple: **`config/<path>` → `~/.config/<path>`** and **`home/<path>` → `~/<path>`**.

Files are linked **one by one**, so they sit next to Omarchy's own files (in `~/.config/hypr`, for example) without replacing the whole folder.
Folders listed in `LINK_DIRS` inside `install.sh` (currently only `nvim`) are linked whole.

## 🚀 Getting started

### 1. Install Omarchy

Download the ISO from [omarchy.org](https://omarchy.org), flash it to a USB stick and follow the installer.
[The Omarchy Manual](https://learn.omacom.io/2/the-omarchy-manual) covers each step.

### 2. Clone this repo

```bash
git clone https://github.com/Dawtio/dotfiles.git ~/Projects/Dawtio/dotfiles
cd ~/Projects/Dawtio/dotfiles
```

### 3. Preview, then link

```bash
./install.sh --dry-run   # show what would happen
./install.sh             # do it
```

Any existing file that differs from the repo is moved aside as `<name>.bak-<timestamp>`, so nothing is lost.
Files that are already identical are simply replaced by the link.

### 4. Finish up

```bash
mise install             # install the tool versions from config/mise/config.toml
hyprctl reload           # pick up the Hyprland changes
nvim                     # lazy.nvim bootstraps itself and installs the plugins
```

> [!NOTE]
> Some files are specific to my machine and identity. Edit them before using this repo yourself:
> `config/hypr/monitors.lua` (monitor names and layout) and `config/git/config` (name, email, signing key).

## 🔄 Day-to-day

Since everything is a symlink, editing `~/.config/...` edits the repo directly. Commit whenever you like.

```bash
./install.sh --status
```

```
links: 27 ok, 0 to fix (run ./install.sh)
uncommitted changes:
 M config/hypr/bindings.lua
```

| Status | Meaning | Fix |
|---|---|---|
| `missing` | The link isn't in place yet | `./install.sh` |
| `unlinked` | A plain file sits there, but its content matches the repo | `./install.sh` |
| `drift` | A plain file with **different** content replaced the link | Copy it into the repo, then `./install.sh` |

> [!TIP]
> Some tools save by writing a new file instead of editing in place, which replaces the symlink with a regular file.
> The Omarchy shell does this to `shell.json` when you change the bar from the UI, and Omarchy updates can do it to hypr files.
> Run `--status` now and then to catch it.

**Tracking a new file:** copy it to the matching path under `config/` or `home/`, then run `./install.sh`.

## 🔗 Links

- [Omarchy](https://omarchy.org) · [Manual](https://learn.omacom.io/2/the-omarchy-manual) · [Source](https://github.com/basecamp/omarchy)
- [Hyprland wiki](https://wiki.hypr.land)
- [Neovim](https://neovim.io) · [lazy.nvim](https://lazy.folke.io)
- [Starship](https://starship.rs) · [mise](https://mise.jdx.dev) · [opencode](https://opencode.ai)

## 📄 License

Released under the [MIT License](LICENSE). Borrow anything you like.
