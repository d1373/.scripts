#!/usr/bin/env bash
set -euo pipefail

# Build file list once, then show only short labels in rofi.
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

fd . "$HOME/dev" "$HOME/Documents" "$HOME/Pictures" "$HOME/Downloads" "$HOME/Notes" "$HOME/Videos" \
  --type f --hidden --follow --exclude .git --exclude node_modules 2>/dev/null \
| sort \
| tee "$tmp" \
| awk -F/ 'NF>=2 { print $(NF-1) "/" $NF; next } { print $0 }' \
| rofi -dmenu -i -sorting-method fzf -p "Open" \
    -format i \
    -theme-str '* { text-wrap: false; } #window { width: 900px; } listview { lines: 12; }' \
| {
    read -r idx || exit 0
    [ -z "${idx:-}" ] && exit 0
    full="$(sed -n "$((idx+1))p" "$tmp")"
    [ -n "$full" ] && xdg-open "$full" >/dev/null 2>&1 &
  }
