{ config, lib, pkgs, ... }:
with
lib;
{
  options.kirby.machine.workstation = {
    enable = mkEnableOption "Enable linux workstation";
  };

  config = mkIf config.kirby.machine.workstation.enable {
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

      bspwm.enable = true;
      compton.enable = true;
      polybar.enable = true;
      dunst.enable = true;
      sxhkd.enable = true;
      alacritty.enable = true;
      scripts.enable = true;
      xconfig.enable = true;
      rofi = {
        enable = true;
        resolution = "720p";
      };
    };

    kirby.service = {
      dropbox.enable = true;
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
      ibus
    ];

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; with pkgs.fcitx5; [ fcitx5-rime fcitx5-mozc fcitx5-gtk fcitx5-chinese-addons ];
    };

    fonts.fontconfig.enable = true;

    home.file = {
      ".xinitrc" = {
        executable = true;
        text = ''
          if [ -z "$HM_XPROFILE_SOURCED" ]; then
            . "/home/fatmonad/.xprofile"
          fi
          unset HM_XPROFILE_SOURCED
          xset -b
          fcitx5 &
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
