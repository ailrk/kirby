{ config, lib, pkgs, ... }:
let
  cfg = config.elemental.home.program.editor.emacs;
in
{

  options.elemental.home.program.editor.emacs = {
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
