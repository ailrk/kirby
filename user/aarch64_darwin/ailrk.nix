# ailrk
{ config, lib, pkgs, ... }:
with lib;
{
  options.kirby.user.aarch64_darwin.ailrk = {
    enable = mkEnableOption "Set user as a ailrk";
  };

  config = mkIf config.kirby.user.aarch64_darwin.ailrk.enable {
    home.stateVersion = "23.11";
    home.username = "ailrk";
    home.homeDirectory = "/Users/ailrk";
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
        scripts.enable = true;
        nmap.enable = true;
        zsh.enable = true;
        fish.enable = true;
      };
    };

    # Install packages
    home.packages = with pkgs;
      [ tmux

        # utils
        zlib.dev
        zlib.out
        gmp
        cabal2nix
        binutils


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
      ];

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "kitty";
    };

    nixpkgs.config = {
      allowUnfree = true;
      pulseaudio = true;
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
