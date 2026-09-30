#!/usr/bin/env bash
# Symlink dotfiles into place:
#   config/<path> -> $XDG_CONFIG_HOME/<path>  (default ~/.config)
#   home/<path>   -> $HOME/<path>
#
# Files are linked one by one so they can live next to Omarchy's own files
# (e.g. ~/.config/hypr). Directories listed in LINK_DIRS are linked whole.
#
# A regular file already at the target is replaced by the link when identical,
# otherwise moved to <name>.bak-<timestamp> first.
#
# Usage: ./install.sh [-n|--dry-run] [-s|--status]
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DEST="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"
LINK_DIRS=(config/nvim)
MODE=install

case "${1:-}" in
  -n | --dry-run) MODE=dry-run ;;
  -s | --status) MODE=status ;;
  "") ;;
  *) echo "usage: $0 [-n|--dry-run] [-s|--status]" >&2; exit 1 ;;
esac

run() {
  if [[ $MODE == dry-run ]]; then echo "  would: $*"; else "$@"; fi
}

target_for() {
  case "$1" in
    config/*) echo "$CONFIG_DEST/${1#config/}" ;;
    home/*) echo "$HOME/${1#home/}" ;;
  esac
}

link() {
  local rel="$1" src="$DOTFILES/$1" target
  target="$(target_for "$rel")"

  if [[ -L "$target" && "$(readlink -f "$target")" == "$(readlink -f "$src")" ]]; then
    [[ $MODE == status ]] || echo "ok      $rel"
    return
  fi

  if [[ $MODE == status ]]; then
    if [[ ! -e "$target" && ! -L "$target" ]]; then
      echo "missing $rel"
    elif [[ -f "$target" && ! -L "$target" ]] && cmp -s "$src" "$target"; then
      echo "unlinked $rel (same content)"
    else
      echo "drift   $rel"
    fi
    return
  fi

  if [[ -f "$target" && ! -L "$target" ]] && cmp -s "$src" "$target"; then
    run rm "$target"
  elif [[ -e "$target" || -L "$target" ]]; then
    echo "backup  $rel -> $(basename "$target").bak-$STAMP"
    run mv "$target" "$target.bak-$STAMP"
  fi

  echo "link    $rel"
  run mkdir -p "$(dirname "$target")"
  run ln -s "$src" "$target"
}

cd "$DOTFILES"

prune=()
for d in "${LINK_DIRS[@]}"; do
  link "$d"
  prune+=(-path "$d" -prune -o)
done

while IFS= read -r -d '' f; do
  link "$f"
done < <(find config home "${prune[@]}" -type f -print0 | sort -z)
