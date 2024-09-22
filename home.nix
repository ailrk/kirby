{ config, pkgs, lib, ... }:
with lib;
let
  home = builtins.getEnv "HOME";
in
{
  imports = [
    ./program/default.nix
    ./service/default.nix
    ./user/default.nix
  ];

  kirby.user.x86_64_linux.fatmonad = mkIf (home == "/home/fatmonad") {
    enable = true;
  };

  kirby.user.aarch64_darwin.ailrk = mkIf (home == "/Users/ailrk") {
    enable = true;
  };
}
