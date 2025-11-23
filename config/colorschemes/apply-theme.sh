#!/bin/sh

# Script Arguments
THEME="$1"
# Global Configuration
COLORSCHEMES_DIR="$HOME/.config/colorschemes"
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/$THEME"
# Computed variable.
THEME_DIR="$COLORSCHEMES_DIR/$THEME"
CURRENT_THEME_FILE="$COLORSCHEMES_DIR/.current-theme"

die() {
  _exit_code=$1
  _message=$2

  # Send a message notification for 3s.
  notify-send ${_message} -t 3000
  exit ${_exit_code}
}

check_params() {
  if [ -z "$THEME" ]; then die 1 "No theme provided."; fi
  if [ ! -d "$THEME_DIR" ]; then die 1 "Theme selected seems missing."; fi
}

set_hyprland_theme() {
  echo "Updating Hyprland configuration..."
  cp "$THEME_DIR/hypr/colors.conf" "$HOME/.config/hypr/colors/colors.conf" >/dev/null 2>&1
  echo ""
}

set_waybar_theme() {
  echo "Applying Waybar CSS..."
  cp "$THEME_DIR/waybar/colors.css" "$HOME/.config/waybar/colors/colors.css" >/dev/null 2>&1
  echo "Restarting Waybar..."
  pkill waybar >/dev/null 2>&1 && ~/.config/waybar/launch.sh >/dev/null 2>&1 &
  disown
  echo ""
}

set_terminal_theme() {
  echo "Applying terminal theme..."
  case "$THEME" in
  everforest-dark | gruvbox-dark | catppuccin | tokyo-night | kanagawa | nord-darker | noir | e-ink | nightfox | rose-pine)
    cp "$THEME_DIR/kitty/colors.conf" "$HOME/.config/kitty/colors/colors.conf" >/dev/null 2>&1
    ;;
  *)
    echo "No terminal theme defined for $THEME. Skipping."
    ;;
  esac
  pgrep kitty | xargs -r kill -SIGUSR1 >/dev/null 2>&1
  echo ""
}

set_swaync_theme() {
  echo "Applying SwayNC theme..."
  cp "$THEME_DIR/swaync/colors.css" "$HOME/.config/swaync/colors/colors.css" >/dev/null 2>&1
  pkill swaync >/dev/null 2>&1 && swaync >/dev/null 2>&1 &
  disown
  echo ""
}

set_wlogout_theme() {
  echo "Applying wlogout theme..."
  cp "$THEME_DIR/wlogout/colors.css" "$HOME/.config/wlogout/colors/colors.css" >/dev/null 2>&1
  echo ""
}

set_rofi_theme() {
  echo "Applying Rofi theme..."
  cp "$THEME_DIR/rofi/colors.rasi" "$HOME/.config/rofi/colors/colors.rasi" >/dev/null 2>&1
  echo ""
}

set_discord_theme() {
  echo "Applying Discord theme..."
  cp "$THEME_DIR/discord/current.theme.css" "$HOME/.config/vesktop/themes/" >/dev/null 2>&1
  echo ""
}

set_gtk_theme() {
  if [ -f "$THEME_DIR/gtk-theme" ]; then
    GTK_THEME_NAME=$(cat "$THEME_DIR/gtk-theme")
    echo "Setting GTK theme to '$GTK_THEME_NAME'..."
    # gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME_NAME" >/dev/null 2>&1
    sed --follow-symlinks -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME_NAME/" ~/.config/gtk-3.0/settings.ini
    sed --follow-symlinks -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME_NAME/" ~/.config/gtk-4.0/settings.ini
    sed --follow-symlinks -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME_NAME/" ~/.gtkrc-2.0
    sed --follow-symlinks -i "s/^gtk-theme=.*/gtk-theme=$GTK_THEME_NAME/" ~/.local/share/nwg-look/gsettings
    sed --follow-symlinks -i "s/^Net\/ThemeName .*/Net\/ThemeName \"$GTK_THEME_NAME\"/" ~/.config/xsettingsd/xsettingsd.conf
    nwg-look -a >/dev/null 2>&1
  else
    echo "GTK theme file not found. Skipping."
  fi
  echo ""

  GTK4_SRC="$THEME_DIR/gtk-4.0"
  GTK4_DST="$HOME/.config/gtk-4.0"

  if [[ -d "$GTK4_SRC" ]]; then
    echo "Linking GTK4 theme files..."
    mkdir -p "$GTK4_DST"
    ln -sf "$GTK4_SRC/gtk.css" "$GTK4_DST/gtk.css"
    ln -sf "$GTK4_SRC/gtk-dark.css" "$GTK4_DST/gtk-dark.css"
    ln -sfn "$GTK4_SRC/assets" "$GTK4_DST/assets"
  else
    echo "No GTK4 theme files found in $GTK4_SRC. Skipping."
  fi
  echo ""
}

set_wallpaper() {
  echo "Setting wallpaper..."

  # Create state file if it doesn't exist
  _wallpaper_state="$HOME/.config/colorschemes/.wallpaper-state"
  touch "${_wallpaper_state}"

  # Get saved wallpaper for this theme
  _saved_wallpaper=$(grep "^$THEME:" "${_wallpaper_state}" | cut -d':' -f2-)

  if [ -n "${_saved_wallpaper}" ] && [ -f "${_saved_wallpaper}" ]; then
    # Use saved wallpaper
    _wallpaper="${_saved_wallpaper}"
    echo "Using saved wallpaper"
  elif [ -d "$WALLPAPER_DIR" ]; then
    # Get first wallpaper from directory (sorted alphabetically)
    _wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort | head -n1)

    if [ -n "${_wallpaper}" ]; then
      # Save this as the default for this theme
      sed -i "/^$THEME:/d" "${_wallpaper_state}"
      echo "$THEME:${_wallpaper}" >>"${_wallpaper_state}"
      echo "Using first wallpaper (default)"
    else
      echo "No wallpapers found in $WALLPAPER_DIR"
    fi
  else
    echo "Wallpaper directory not found: $WALLPAPER_DIR"
  fi

  if [ -n "${_wallpaper}" ] && [ -f "${_wallpaper}" ]; then
    awww img "${_wallpaper}" --transition-type center --transition-fps 144 --transition-step 255 >/dev/null 2>&1
    # Update hyprlock symlink
    ln -sf "${_wallpaper}" ~/.config/hypr/hyprlock/wallpaper
  else
    echo "Could not set wallpaper"
  fi
  echo ""
}

main() {
  # Track current theme
  echo "$THEME" >"$CURRENT_THEME_FILE"

  echo "Applying theme: $THEME\n"
  notify-send "Theme Switching" "Applying theme: $THEME" -t 3000

  set_wallpaper

  set_hyprland_theme
  set_waybar_theme
  set_gtk_theme
  set_wlogout_theme
  set_terminal_theme
  set_discord_theme
  set_rofi_theme
  set_swaync_theme

  # Final success notification
  notify-send "Theme Applied" "Successfully switched to: $THEME" -t 5000
}

check_params
main
