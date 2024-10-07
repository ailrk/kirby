if [ -z "$HM_XPROFILE_SOURCED" ]; then
  . "$HOME/.xprofile"
fi
unset HM_XPROFILE_SOURCED
xset -b
xinput set-prop 7 "libinput Accel Speed" 0.4
exec bspwm
