# fatmonad
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.linux_x86.fatmonad = {
    enable = mkEnableOption "Set user as a fatmonad";
  };

  config = mkIf config.kirby.user.linux_x86.fatmonad.enable {
    home.stateVersion = "23.11";
    home.username = "fatmonad";
    home.homeDirectory = "/home/fatmonad";
    manual.manpages.enable = false;

    kirby = {
      program = {
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
        neovim = {
          enable = true;
          nightly = false;
        };
        ranger.enable = true;
        tmux.enable = true;
        bspwm.enable = true;
        compton.enable = true;
        polybar.enable = true;
        sxhkd.enable = true;
        dunst.enable = true;
        alacritty.enable = true;
        scripts.enable = true;
        xconfig.enable = true;
        rofi = {
          enable = true;
          resolution = "720p";
        };
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
        nemo.enable = true;
        taskwarrior.enable = true;
      };

      service = {
        dropbox.enable = true;
      };
    };

    services.gpg-agent = {
     enable = true;
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; with pkgs.fcitx5; [ fcitx5-rime fcitx5-mozc fcitx5-gtk fcitx5-chinese-addons ];
    };

  fonts.fontconfig.enable = true;

    # Install packages
    home = {
      packages = with pkgs;
        [ tmux

          # utils
          zlib.dev
          zlib.out
          gmp
          cabal2nix

          # cli tools
          htop
          inetutils
          ripgrep
          killall
          expect
          fd
          bat
          fzf
          git-crypt
          gnupg

          # font
          fira-code
          paratype-pt-mono

          any-nix-shell
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

          # font
          iosevka
          meslo-lg

          # language
          smlnj
          racket
          purescript
          valgrind
          dotnet-sdk
          fsharp
          nil

          # Data, Files and Networking
          sshfs
          iotop
          fio
          acpi
          scrot

          # user
          google-chrome
          wireshark-qt
          muse
          blender
          xournalpp
          aseprite
          xfce.thunar
          blueman

          # languages
          gnumake
          ocaml
          cmake
          rebar3
          rustup
          nodejs

          # Jokes
          cowsay
          fortune
          figlet
          lolcat
          nms

          # others
          mupdf
          ncmpcpp
          zathura
          weechat-unwrapped
          nodePackages.bash-language-server
          nodePackages.typescript-language-server

          tdesktop
          discord
        ];

      file = {
        ".xinitrc" = {
          executable = true;
          text = builtins.readFile ./.xinitrc;
        };

        ".xsession" = {
          executable = true;
          text = builtins.readFile ./.xsession;
        };

        ".xprofile" = {
          executable = true;
          text = builtins.readFile ./.xprofile;
        };

        ".profile" = {
          executable = true;
          text = builtins.readFile ./.profile;
        };

        ".Xresources" = {
          executable = true;
          text = builtins.readFile ./.Xresources;
        };
      };

      # Environment
      sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "google-chrome-stable";
        TERMINAL = "nixGL alacritty";
        TERM = "nixGL alacritty";
      };
    };


    # User specific overlays.
    nixpkgs.overlays = [
      # discord
      (self: super: {
        discord = super.discord.overrideAttrs (_: {
          src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;
        });
      })
    ];
  };
}
