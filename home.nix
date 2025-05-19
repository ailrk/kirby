{ config, pkgs, lib, ... }:
let
  trim = s: builtins.elemAt (builtins.match "^[ \n\r\t]*([^ \n\r\t]+)[ \n\r\t]*$" s) 0;
  colorMode = trim (builtins.readFile ~/.config/kirby/color-mode);
  system = builtins.currentSystem;  # Use currentSystem to detect platform
  machine = {
    "x86_64-linux" = {
      imports = [ ./machine/linux_x86/fatmonad.nix ];
      kirby.home.linux_x86.fatmonad = {
        enable = true;
        colorMode = colorMode;
      };
    };
    "aarch64-darwin" = {
      imports = [ ./machine/darwin_m1/ailrk.nix ];
      kirby.home.darwin_m1.ailrk.enable = true;
    };
    "aarch64-linux" = {
      imports = [ ./machine/linux_m1/ailrk-asahi.nix ];
      kirby.home.linux_m1.ailrk_asahi = {
        enable  = true;
        colorMode = colorMode;
      };
    };
  };
in
  if system != null && builtins.hasAttr system machine then
    machine.${system}
  else
    "unknown machine"
