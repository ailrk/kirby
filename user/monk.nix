# A monk who only process documents..
{ config, lib, pkgs, ... }:
with lib;
{ 
  options.kirby.user.monk = {
    enable = mkEnableOption "Set user as a monk";
  };

  config = mkIf config.kirby.user.monk.enable {
    kirby.program = {
      neovim = {
        enable = true;
        nightly = false;
      };
      fish.enable = true;
      ranger.enable = true;
      taskwarrior.enable = true;
    };

    home.packages = with pkgs; [
      ripgrep
      fd
      fzf
      mupdf
      ncmpcpp
      zathura
      any-nix-shell
    ];
  };
}

