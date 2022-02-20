{ config, pkgs, lib, ... }:

{
  imports = [
    ./elemental.nix
    ./home/default.nix
  ];

  # Let Home Manager install itself
  # programs.home-manager.enable = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  elemental.machine = "fatmonad";
  elemental.role = "workstation";
  elemental.user = "ailrk";
}
