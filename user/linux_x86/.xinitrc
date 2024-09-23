if [ -z "$HM_XPROFILE_SOURCED" ]; then
  . "/home/fatmonad/.xprofile"
fi
unset HM_XPROFILE_SOURCED
xset -b
fcitx5 &
exec bspwm
