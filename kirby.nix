{ config, lib, pkgs, ... }:
let
  cfg = config.kirby;
in
{

  # machine specific configurations
  options.kirby.machine = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      The hostname of the device.
    '';
    example = "fatmonad";
  };

  # machine agnostic general configuration
  options.kirby.role = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      The device role, this determines the window manager and GUI tools to be installed.
    '';
    example = "workstation";
  };

  options.kirby.user = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      The username of the primary user.
    '';
    example = "ailrk";
  };
}
