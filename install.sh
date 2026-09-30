#!/usr/bin/env bash
# Symlink every entry of ./config into $XDG_CONFIG_HOME (default ~/.config).
# Existing files that aren't already our symlinks are moved to <name>.bak-<timestamp>.
#
# Usage: ./install.sh [-n|--dry-run]
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$DOTFILES/config"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0

case "${1:-}" in
  -n | --dry-run) DRY_RUN=1 ;;
  "") ;;
  *) echo "usage: $0 [-n|--dry-run]" >&2; exit 1 ;;
esac

run() {
  if ((DRY_RUN)); then echo "  would: $*"; else "$@"; fi
}

mkdir -p "$DEST"

for src in "$SRC"/* "$SRC"/.[!.]*; do
  [[ -e "$src" ]] || continue
  name="$(basename "$src")"
  target="$DEST/$name"

  if [[ -L "$target" && "$(readlink -f "$target")" == "$(readlink -f "$src")" ]]; then
    echo "ok      $name"
    continue
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    echo "backup  $name -> $name.bak-$STAMP"
    run mv "$target" "$target.bak-$STAMP"
  fi

  echo "link    $name"
  run ln -s "$src" "$target"
done
