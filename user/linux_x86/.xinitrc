if [ -z "$HM_XPROFILE_SOURCED" ]; then
  . "/home/fatmonad/.xprofile"
fi
unset HM_XPROFILE_SOURCED
set   GTK_IM_MODULE=fcitx
xset -b
fcitx5 &
exec bspwm
