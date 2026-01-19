#!/usr/bin/env bash

# Rofi power menu (Nerd Font icons)
# Requirements: rofi

ROFI="rofi -dmenu -i -p 'Power'"

# Options (icons from Nerd Fonts)
shutdown="  Shutdown"
reboot="󰜉  Reboot"
logout="󰍃  Logout (Awesome)"
awesome_restart="󰑓  Restart (Awesome)"
lock="󰍣  Lock"

chosen=$(printf "%s\n%s\n%s\n%s\n" \
  "$shutdown" "$reboot" "$logout" "$awesome_restart" "$lock" | eval "$ROFI")

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
  "$lock")
    betterlockscreen -l
    ;;
  "$awesome_restart")
    awesome-client "awesome.restart()"
    ;;
  *)
    exit 0
    ;;
esac
