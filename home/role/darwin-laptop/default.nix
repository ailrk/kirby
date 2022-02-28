{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.home.role.darwin-laptop;
in
{

  imports = [
    # DE
    ./de/skhd/default.nix
    ./de/yabai/default.nix
  ];

  options.kirby.home.role.darwin-laptop = {
    enable = mkEnableOption "Enable mac role";
  };

  config = mkIf (config.kirby.role == "darwin-laptop") {

    kirby.home.program.scripts.enable = true;
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      lsof
      xclip
      pinentry
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "kitty";
    };

  };
}
