{ config, pkgs, lib, ... }:

{
  imports = [
    ./program/default.nix
    ./service/default.nix
    ./machine/default.nix
    ./user/default.nix
  ];

  home.username = "fatmonad";
  home.homeDirectory = "/home/fatmonad";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  manual.manpages.enable = false;

  # 
  # kirby configuration. You can pick any machine and 
  # user config as long as their configurations don't
  # conflict
  #
  kirby = {
    machine.workstation.enable = true;
    user.programmer.enable = true;
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
}
