{ config, lib, pkgs, ... }:
with
lib;
let
  linux =
    lib.optionals
    (builtins.currentSystem == "x86_64-linux")
    [
      ./workstation/default.nix
    ];

  mac =
    lib.optionals
    (builtins.currentSystem == "aarch64-darwin")
    [
      ./darwin-laptop/default.nix
    ];
in

{

  imports = linux ++ mac;
}
