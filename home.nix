{ config, pkgs, lib, ... }:
with lib;
let
  home = builtins.getEnv "HOME";
in
  if home == "/home/fatmonad" then
  {
    imports = [
        ./program/default.nix
        ./program/linux.nix
        ./service/default.nix
        ./user/linux_x86/fatmonad.nix
      ];

    kirby.user.linux_x86.fatmonad.enable = true;
  }
  else if home == "/Users/ailrk" then
  {
    imports = [
        ./program/default.nix
        ./program/darwin.nix
        ./service/default.nix
        ./user/darwin_m1/ailrk.nix
      ];
    kirby.user.darwin_m1.ailrk = {
      enable  = true;
      core    = true;
      nix     = true;
      cli     = true;
      haskell = false;
      fonts   = true;
      extra   = [ pkgs.qemu ];
    };
  } else abort "unknown user"
