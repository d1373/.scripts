#!/bin/bash

current=$(defaults read -g ApplePressAndHoldEnabled 2>/dev/null)

if [ "$current" == "1" ]; then
  defaults write -g ApplePressAndHoldEnabled -bool false
  echo "Key repeat mode enabled."
else
  defaults write -g ApplePressAndHoldEnabled -bool true
  echo "Accent menu enabled."
fi

killall Finder
