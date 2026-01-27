#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Ghostty
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "session", "optional": true }

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Ghostty Open

# Documentation:
# @raycast.description Opens Ghostty with url protocol
# @raycast.author kalle_pyorala
# @raycast.authorURL https://raycast.com/kalle_pyorala

if [ -n "$1" ]; then
  if [ "$(/opt/homebrew/bin/tmux list-clients 2>/dev/null | wc -c)" -gt 1 ]; then
    open -a Ghostty
    /opt/homebrew/bin/sesh connect -s "$1"
  else
    open -a Ghostty
    sleep 0.3
    osascript -e "tell application \"System Events\" to keystroke \"tmux new -A -s $1\"" -e "tell application \"System Events\" to key code 36"
  fi
else
  open -a Ghostty
fi
