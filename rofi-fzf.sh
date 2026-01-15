#!/usr/bin/env bash
set -euo pipefail

TAIL=3  # how many trailing path components to show (x/y/file = 3)

fd . "$HOME/dev" "$HOME/Documents" "$HOME/Pictures" "$HOME/Downloads" "$HOME/Notes" "$HOME/Videos" \
  --type f --hidden --follow --exclude .git --exclude node_modules 2>/dev/null \
| awk -v n="$TAIL" -F/ '
  {
    full=$0
    if (NF <= n) {
      disp=full
    } else {
      disp=$(NF-n+1)
      for (i=NF-n+2; i<=NF; i++) disp=disp "/" $i
      disp="…/" disp
    }
    # output: display<TAB>fullpath
    print disp "\t" full
  }' \
| rofi -dmenu -i -matching fuzzy -p "Open" \
| cut -f2- \
| xargs -r xdg-open >/dev/null 2>&1 &
