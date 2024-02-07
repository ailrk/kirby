# A programmer who does everything with a computer.
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.programmer = {
    enable = mkEnableOption "Set user as a programmer";
  };

  config = mkIf config.kirby.user.programmer.enable {
    kirby.program = {
      nmap.enable = true;
      emacs.enable = true;
      neovim = {
        enable = true;
        nightly = false;
      };
      zsh.enable = true;
      fish.enable = true;
      nemo.enable = true;
      ranger.enable = true;
      tmux.enable = true;
      taskwarrior.enable = true;
    };

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

          # nix
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
      sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "google-chrome-stable";
        TERMINAL = "nixGL alacritty";
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
