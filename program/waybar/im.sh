#!/bin/bash
# Get the current input method name
current=$(fcitx5-remote -n)

# Map long names to short labels or icons
case "$current" in
    "keyboard-us") echo "EN" ;;
    "mozc")        echo "JP" ;;
    "pinyin")      echo "CN" ;;
    *)             echo "$current" ;; # Fallback to raw name
esac
