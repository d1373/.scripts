#!/bin/bash

selected=$(sesh list --icons | fzf \
  --ansi \
  --border-label ' sesh ' \
  --prompt '⚡  ' \
  --layout=reverse \
)

if [ -n "$selected" ]; then
  sesh connect "$selected"
fi
