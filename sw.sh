#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $(basename "$0") /path/to/image"
  exit 1
fi

img="$1"

# Expand ~ manually if present
img="${img/#\~/$HOME}"

if [[ ! -f "$img" ]]; then
  echo "Error: file not found: $img"
  exit 1
fi

# Set desktop wallpaper (X11)
feh --bg-fill "$img"

# Update betterlockscreen cache
betterlockscreen -u "$img"

echo "Wallpaper set:"
echo "  Desktop: $img"
echo "  Lockscreen updated via betterlockscreen"
