if [ -z "$HM_XPROFILE_SOURCED" ]; then
  . "$HOME/.xprofile"
fi

# Environment variable
unset HM_XPROFILE_SOURCED
set   GTK_IM_MODULE=fcitx

xset -b
fcitx5 &
xinput set-prop 7 "libinput Accel Speed" 0.4

systemctl --user import-environment DISPLAY PATH
exec bspwm
