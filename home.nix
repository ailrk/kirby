{ config, pkgs, lib, ... }:

{
  imports = [
    ./program/default.nix
    ./service/default.nix
    ./machine/default.nix
    ./user/default.nix
  ];

  manual.manpages.enable = false;

  # 
  # kirby configuration.
  #
  kirby = {
    machine.workstation.enable = true;
    user.programmer.enable = true;
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
}
