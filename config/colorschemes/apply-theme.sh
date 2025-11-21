#!/bin/sh
# Color codes
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

THEME="$1"
THEME_DIR="$HOME/.config/colorschemes/$THEME"
WALLPAPER_STATE="$HOME/.config/colorschemes/.wallpaper-state"

if [ -z "$THEME" ]; then
  echo -e "${YELLOW}Usage: $0 <theme-name>${NC}"
  exit 1
fi

if [ ! -d "$THEME_DIR" ]; then
  echo -e "${YELLOW}Theme '$THEME' does not exist at $THEME_DIR${NC}"
  notify-send "Theme Error" "Theme '$THEME' not found" -u critical
  exit 1
fi

# Track current theme
CURRENT_THEME_FILE="$HOME/.config/colorschemes/.current-theme"
echo "$THEME" >"$CURRENT_THEME_FILE"

echo -e "${GREEN}Applying theme: $THEME${NC}\n"
notify-send "Theme Switching" "Applying theme: $THEME" -t 3000

# Hyprland config
echo -e "${CYAN}-> Updating Hyprland configuration...${NC}"
cp "$THEME_DIR/hypr/colors.conf" "$HOME/.config/hypr/colors/colors.conf" >/dev/null 2>&1
echo ""

# Waybar style
echo -e "${CYAN}-> Applying Waybar CSS...${NC}"
cp "$THEME_DIR/waybar/colors.css" "$HOME/.config/waybar/colors/colors.css" >/dev/null 2>&1
echo -e "${CYAN}-> Restarting Waybar...${NC}"
pkill waybar >/dev/null 2>&1 && ~/.config/waybar/launch.sh >/dev/null 2>&1 &
disown
echo ""

# Wallpaper
echo -e "${CYAN}-> Setting wallpaper...${NC}"
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/$THEME"

# Create state file if it doesn't exist
touch "$WALLPAPER_STATE"

# Get saved wallpaper for this theme
SAVED_WALLPAPER=$(grep "^$THEME:" "$WALLPAPER_STATE" | cut -d':' -f2-)

if [ -n "$SAVED_WALLPAPER" ] && [ -f "$SAVED_WALLPAPER" ]; then
  # Use saved wallpaper
  WALLPAPER="$SAVED_WALLPAPER"
  echo -e "${CYAN}   Using saved wallpaper${NC}"
elif [ -d "$WALLPAPER_DIR" ]; then
  # Get first wallpaper from directory (sorted alphabetically)
  WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort | head -n1)

  if [ -n "$WALLPAPER" ]; then
    # Save this as the default for this theme
    sed -i "/^$THEME:/d" "$WALLPAPER_STATE"
    echo "$THEME:$WALLPAPER" >>"$WALLPAPER_STATE"
    echo -e "${CYAN}   Using first wallpaper (default)${NC}"
  else
    echo -e "${YELLOW}   No wallpapers found in $WALLPAPER_DIR${NC}"
  fi
else
  echo -e "${YELLOW}   Wallpaper directory not found: $WALLPAPER_DIR${NC}"
fi

if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
  awww img "$WALLPAPER" --transition-type center --transition-fps 144 --transition-step 255 >/dev/null 2>&1
  # Update hyprlock symlink
  ln -sf "$selected_path" ~/.config/hypr/hyprlock/wallpaper
else
  echo -e "${YELLOW}   Could not set wallpaper${NC}"
fi
echo ""

# GTK Theme
if [ -f "$THEME_DIR/gtk-theme" ]; then
  GTK_THEME_NAME=$(cat "$THEME_DIR/gtk-theme")
  echo -e "${CYAN}-> Setting GTK theme to '$GTK_THEME_NAME'...${NC}"
  # gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME_NAME" >/dev/null 2>&1
  sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME_NAME/" ~/.config/gtk-3.0/settings.ini
  sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME_NAME/" ~/.config/gtk-4.0/settings.ini
  sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME_NAME/" .gtkrc-2.0
  sed -i "s/^gtk-theme=.*/gtk-theme=$GTK_THEME_NAME/" .local/share/nwg-look/gsettings
  sed -i "s/^Net\/ThemeName .*/Net\/ThemeName \"$GTK_THEME_NAME\"/" ./xsettingsd/xsettingsd.conf
  nwg-look -a
else
  echo -e "${YELLOW}-> GTK theme file not found. Skipping.${NC}"
fi
echo ""

GTK4_SRC="$THEME_DIR/gtk-4.0"
GTK4_DST="$HOME/.config/gtk-4.0"

if [[ -d "$GTK4_SRC" ]]; then
  echo -e "${CYAN}-> Linking GTK4 theme files...${NC}"
  mkdir -p "$GTK4_DST"
  ln -sf "$GTK4_SRC/gtk.css" "$GTK4_DST/gtk.css"
  ln -sf "$GTK4_SRC/gtk-dark.css" "$GTK4_DST/gtk-dark.css"
  ln -sfn "$GTK4_SRC/assets" "$GTK4_DST/assets"
else
  echo -e "${YELLOW}-> No GTK4 theme files found in $GTK4_SRC. Skipping.${NC}"
fi
echo ""

# Terminal theme
echo -e "${CYAN}-> Applying terminal theme...${NC}"
case "$THEME" in
everforest-dark | gruvbox-dark | catppuccin | tokyo-night | kanagawa | nord-darker | noir | e-ink | nightfox | rose-pine)
  cp "$THEME_DIR/kitty/colors.conf" "$HOME/.config/kitty/colors/colors.conf" >/dev/null 2>&1
  ;;
*)
  echo -e "${YELLOW}-> No terminal theme defined for $THEME. Skipping.${NC}"
  ;;
esac
pgrep kitty | xargs -r kill -SIGUSR1 >/dev/null 2>&1
echo ""

# SwayNC theme
echo -e "${CYAN}-> Applying SwayNC theme...${NC}"
cp "$THEME_DIR/swaync/colors.css" "$HOME/.config/swaync/colors/colors.css" >/dev/null 2>&1
pkill swaync >/dev/null 2>&1 && swaync >/dev/null 2>&1 &
disown
echo ""

# wlogout theme
echo -e "${CYAN}-> Applying wlogout theme...${NC}"
cp "$THEME_DIR/wlogout/colors.css" "$HOME/.config/wlogout/colors/colors.css" >/dev/null 2>&1
echo ""

# Rofi theme
echo -e "${CYAN}-> Applying Rofi theme...${NC}"
cp "$THEME_DIR/rofi/colors.rasi" "$HOME/.config/rofi/colors/colors.rasi" >/dev/null 2>&1
echo ""

# Discord theme
echo -e "${CYAN}-> Applying Discord theme...${NC}"
cp "$THEME_DIR/discord/current.theme.css" "$HOME/.config/vesktop/themes/" >/dev/null 2>&1
echo ""

# Final success notification
notify-send "Theme Applied" "Successfully switched to: $THEME" -t 5000
