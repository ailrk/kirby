{ config, lib, pkgs, ... }:
let
  cfg = config.kirby.program.emacs;
in
{

  options.kirby.program.emacs = {
    enable = lib.mkEnableOption "Enable the emacs editor";
  };

  config = lib.mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs.override { inherit (pkgs) imagemagick; };
    };

    home.file.".emacs.d" = {
      source = ./emacs.d;
      recursive = true;
    };
  };
}
