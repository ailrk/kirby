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
        ./user/x86_64_linux/fatmonad.nix
      ];

    kirby.user.x86_64_linux.fatmonad.enable = true;
  }
  else if home == "/Users/ailrk" then
  {
    imports = [
        ./program/default.nix
        ./program/darwin.nix
        ./service/default.nix
        ./user/aarch64_darwin/ailrk.nix
      ];
    kirby.user.aarch64_darwin.ailrk.enable = true;
  } else abort "unknown user"
