{ config, pkgs, lib, ... }:

{
  imports = [
    ./kirby.nix
    ./home/default.nix
  ];

  # Let Home Manager install itself
  # programs.home-manager.enable = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  kirby.machine = "fatmonad";
  kirby.role = "workstation";
  kirby.user = "ailrk";
}
