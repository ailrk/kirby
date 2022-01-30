{ config, lib, pkgs, ... }:
with
lib;
{
  config = mkIf (config.elemental.role == "darwin-laptop") {

    elemental.home.program.scripts.scriptFiles = {
      "set-wall" = ./script/set-wall;
    };

    nixpkgs.config.allowUnfree = true;

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };


#     programs.gpg = {
#       enable = true;
#       settings = {
#         default-key = "0x484DEFFEF37B3BDB";
#       };
#    };
#   };
}
