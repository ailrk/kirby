{ config, lib, pkgs, ... }:
with
lib;
{
  options.kirby.machine.darwin = {
    enable = mkEnableOption "Enable darwin";
  };

  config = mkIf config.kirby.machine.darwin.enable {
    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
    };

    kirby.program = {
      git = {
        enable = true;
        userEmail = "jimmy123good@gmail.com";
        userName = "Ailrk";
        signByDefault = true;
        signKey = "~/.ssh/id_rsa.pub";
        extraConfig = {
          gpg.format = "ssh";
        };
      };

      skhd.enable = true;
      yabai.enable = true;
      scripts.enable = true;
    };

    kirby.service = {
      dropbox.enable = true;
    };

    home.packages = with pkgs; [
    ];

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "kitty";
    };
  };
}
