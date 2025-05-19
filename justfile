setup:
  set-color-mode dark


set-color-mode color:
  mkdir -p ~/.config/kirby && [ -f ~/.config/kirby/color-mode ] && echo {{ color }} > ~/.config/kirby/color-mode
