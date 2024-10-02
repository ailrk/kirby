if [ -z "$HM_XPROFILE_SOURCED" ]; then
  . "$HOME/.xprofile"
fi
unset HM_XPROFILE_SOURCED
xset -b
exec bspwm
