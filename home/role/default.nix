{ config, lib, stdenv, ... }:
{
  imports = [
    ./workstation/default.nix
    ./darwin-laptop/default.nix
  ];
}
