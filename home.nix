{ config, pkgs, lib, ... }:
let
  system = builtins.currentSystem;  # Use currentSystem to detect platform
  machine = {
    "x86_64-linux" = {
      imports = [ ./home/linux_x86/fatmonad.nix ];
      kirby.home.linux_x86.fatmonad.enable = true;
    };
    "aarch64-darwin" = {
      imports = [ ./home/darwin_m1/ailrk.nix ];
      kirby.home.darwin_m1.ailrk.enable = true;
    };
    "aarch64-linux" = {
      imports = [ ./home/linux_m1/ailrk-asahi.nix ];
      kirby.home.linux_m1.ailrk_asahi.enable  = true;
    };
  };
in
  if system != null && builtins.hasAttr system machine then
    machine.${system}
  else
    "unknown machine"
