#!/bin/bash

# Switch layout windows type.
layouts=(scrolling dwindle master)

# Show menu
selected=$(printf '%s\n' "${layouts[@]}" | rofi -dmenu -p "Select Layout" -theme ~/.config/colorschemes/rofi-theme.rasi)

# Apply selected layout if not empty
if [[ -n "$selected" ]]; then
  sed -i "s/bind_.*/bind_${selected}.conf/g" ~/.config/hypr/hyprland_bind.conf
  hyprctl keyword general:layout "$selected"
fi
