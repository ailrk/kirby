{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.elemental.home.role.workstation;
in
{
  config = mkIf (config.elemental.role == "darwin-laptop") {
  }
}

