# ailrk-asahi
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.linux_m1.ailrk_asahi = {
    enable  = mkEnableOption "Set user as a ailrk-asahi";
  };

  config = mkIf config.kirby.user.linux_m1.ailrk_asahi.enable {
    home.stateVersion = "24.05";
    home.username = "ailrk-asahi";
    home.homeDirectory = "/home/ailrk-asahi";
    programs.home-manager.enable = true;

    manual.manpages.enable = false;

    kirby = {
      program = {
        git = {
          enable = true;
          userEmail = "jimmy123good@gmail.com";
          userName = "Ailrk";
          signByDefault = true;
          signKey = "~/.ssh/id_ed25519.pub";
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
        sxhkd.enable = true;
        dunst.enable = true;
        alacritty.enable = true;
        polybar.enable = true;
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
        taskwarrior.enable = true;
        newsflash.enable = true;
        xconfig.enable = true;
        rofi.enable = true;
      };
    };

    # Install packages
    home.packages = [
          # utils
          pkgs.tmux
          pkgs.binutils
          pkgs.rsync
          pkgs.htop
          pkgs.inetutils
          pkgs.ripgrep
          pkgs.killall
          pkgs.expect
          pkgs.fd
          pkgs.bat
          pkgs.fzf
          pkgs.git-crypt
          pkgs.gnupg
          pkgs.texinfo
          pkgs.texliveSmall
          pkgs.neofetch
          pkgs.qemu
          pkgs.xterm
          pkgs.ntp
          pkgs.tldr
          pkgs.w3m
          pkgs.gnupatch
          pkgs.direnv
          (with import <nixgl> { enable32bits = false; }; nixGLMesa)

          # libraries
          pkgs.zlib.dev
          pkgs.zlib.out
          pkgs.libGL
          pkgs.libgcc
          pkgs.gtk4

          # langs
          pkgs.racket
          pkgs.valgrind
          pkgs.ocaml
          pkgs.opam
          pkgs.ocamlPackages.ocaml-lsp
          pkgs.cmake
          pkgs.rustup
          pkgs.nodejs
          pkgs.gnumake
          pkgs.meson
          pkgs.gcc
          pkgs.clang-tools
          pkgs.gdb
          pkgs.cgdb
          pkgs.lld
          pkgs.bear
          pkgs.nasm
          pkgs.lua
          pkgs.lua-language-server
          pkgs.nil
          pkgs.nodePackages.bash-language-server
          pkgs.nodePackages.typescript-language-server
          pkgs.python312Packages.ipython

          # hsakell
          pkgs.ghc
          pkgs.haskell-language-server
          pkgs.ghciwatch
          pkgs.cabal-install

          # nix
          pkgs.any-nix-shell

          # fonts
          pkgs.fira-code
          pkgs.paratype-pt-mono
          pkgs.noto-fonts-cjk-sans
          pkgs.noto-fonts-cjk-serif
          pkgs.font-awesome
          pkgs.wqy_microhei

          # X
          pkgs.xorg.xset
          pkgs.xorg.xinput
          pkgs.brightnessctl
          pkgs.xdotool
          pkgs.xtitle
          pkgs.xdo
          pkgs.pinentry
          pkgs.xclip
          pkgs.scrot

          # gui
          pkgs.ibus
          pkgs.gnome.nautilus
          pkgs.chromium
          pkgs.libsForQt5.qt5.qttools
          pkgs.thunderbird
          pkgs.wireshark-qt
          pkgs.xournalpp
          pkgs.blueman
          pkgs.mupdf
          pkgs.zathura
          pkgs.font-manager
          pkgs.libsForQt5.filelight
        ];


    home.file = {
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

    xdg.configFile = {
      "nix/nix.conf".source = ./nix.conf;

      "bspwm/bspwmrc" = {
          source = ./bspwmrc;
          executable = true;
      };
    };

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "chromium --force-device-scale-factor=1.5";
      TERMINAL = "nixGLMesa alacritty";
      TERM = "nixGLMesa alacritty";
      FILES = "nautilus";
      EMAIL_CLIENT = "thunderbird";
      BATTERY = "macsmc-battery";
      BATTERY_ADAPTOR = "macsmc-ac";
      NIXGL = "nixGLMesa";
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
