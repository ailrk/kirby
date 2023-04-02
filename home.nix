{ config, pkgs, lib, ... }:

{
  imports = [
    ./program/default.nix
    ./service/default.nix
    ./machine/workstation/default.nix
    ./user/ailrk.nix
  ];

  manual.manpages.enable = false;

  kirby.machine.workstation.enable = true;
  kirby.user.ailrk.enable = true;


  # kirby.role = "workstation";
  # kirby.user = "ailrk";

  # Let Home Manager install itself
  # programs.home-manager.enable = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
}
