#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/.config/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-thumbnails"
mkdir -p "$CACHE_DIR"
declare -A wallpapers
while IFS= read -r -d '' img; do
    name=$(basename "$img" | sed 's/\.[^.]*$//')
    thumb="$CACHE_DIR/$(basename "$img").thumb.png"
    [ ! -f "$thumb" ] && convert "$img" -resize 200x200^ -gravity center -extent 200x200 "$thumb" 2>/dev/null &
    wallpapers["$name"]="$img"
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) -print0)
wait
options=""
for name in $(printf '%s\n' "${!wallpapers[@]}" | sort); do
    thumb="$CACHE_DIR/$(basename "${wallpapers[$name]}").thumb.png"
    [ -f "$thumb" ] && options+="$name\0icon\x1f$thumb\n" || options+="$name\n"
done
selected=$(echo -en "$options" | rofi -dmenu -i -p "Wallpaper" -theme-str 'window {width: 900px;} listview {columns: 3; lines: 3;} element-icon {size: 180px;}' -show-icons)
if [ -n "$selected" ]; then
    pgrep -x swww-daemon > /dev/null || swww-daemon &
    sleep 0.3
    swww img "${wallpapers[$selected]}" --transition-type grow --transition-duration 0.6 --transition-fps 120
fi
