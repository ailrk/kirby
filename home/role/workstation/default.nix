{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.home.role.workstation;
in
{
  imports = [
    # DE
    ./de/compton/default.nix
    ./de/dunst/default.nix
    ./de/polybar/default.nix
    ./de/bspwm/default.nix
    ./de/sxhkd/default.nix
  ];

  options.kirby.home.role.workstation = {
    enable = mkEnableOption "Enable linux workstation role";
  };

  config = mkIf (config.kirby.role == "workstation") {

    # Setup lorri and mpd
    # kirby.home.service.dev.lorri.enable = true;
    # kirby.home.service.mpd.enable = true;

    kirby.home.service = {
      dropbox.enable = true;
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
    };

    kirby.home.program = {
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

      alacritty.enable = true;
      scripts.enable = true;
      rofi = {
        enable = true;
        resolution = "720p";
      };
    };

    home.packages = with pkgs; [
      brightnessctl
      xdotool
      xtitle
      lsof
      xdo
      pinentry
      libnotify
      w3m
      xclip
      libGL
    ];

    fonts.fontconfig.enable = true;
    xdg.configFile."nix/nix.conf".source = ./nix.conf;

    home.file = {
      ".xinitrc" = {
        executable = true;
        text = ''
          if [ -z "$HM_XPROFILE_SOURCED" ]; then
            . "/home/fatmonad/.xprofile"
          fi
          unset HM_XPROFILE_SOURCED
          xset -b
          exec bspwm
        '';
      };

      ".xsession" = {
        executable = true;
        text = ''
          source $HOME/.xinitrc
        '';
      };

      ".xprofile" = {
        executable = true;
        text = ''
          . "/home/fatmonad/.nix-profile/etc/profile.d/hm-session-vars.sh"
          if [ -e "$HOME/.profile" ]; then
            . "$HOME/.profile"
          fi

          export HM_XPROFILE_SOURCED=1
        '';
      };

      ".profile" = {
        executable = true;
        text = ''
          export NIX_PATH="$HOME/.nix-defexpr/channels"
          export GTK_IM_MODULE=ibus
          export QT_IM_MODULE=ibus
          export XMODIFIERS=@im=ibus
        '';
      };

    };


    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "nixGL alacritty";
    };

    services.gpg-agent = {
     enable = true;
    };
  };
}
