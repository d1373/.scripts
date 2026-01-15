#!/usr/bin/env bash

# Rofi power menu (Nerd Font icons)
# Requirements: rofi

ROFI="rofi -dmenu -i -p 'Power'"

# Options (icons from Nerd Fonts)
shutdown="  Shutdown"
reboot="󰜉  Reboot"
logout="󰍃  Logout (Awesome)"
awesome_restart="󰑓  Restart (Awesome)"

chosen=$(printf "%s\n%s\n%s\n%s\n" \
  "$shutdown" "$reboot" "$logout" "$awesome_restart" | eval "$ROFI")

case "$chosen" in
  "$shutdown")
    systemctl poweroff
    ;;
  "$reboot")
    systemctl reboot
    ;;
  "$logout")
    awesome-client "awesome.quit()"
    ;;
  "$awesome_restart")
    awesome-client "awesome.restart()"
    ;;
  *)
    exit 0
    ;;
esac
