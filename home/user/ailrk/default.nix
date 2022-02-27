{ config, lib, pkgs, ... }:
with lib;
{
  config = mkIf (config.kirby.user == "ailrk") {
    kirby.home = {
      program = {
        # admin.topgrade.enable = true;
        # networking.ssh.enable = true;
        nmap.enable = true;
        emacs.enable = true;
        neovim.enable = true;
        # zsh.enable = true;
        fish.enable = true;
        ranger.enable = true;
        tmux.enable = true;

        git = {
          enable = true;
          userEmail = "jimmy123good@hotmail.com";
          userName = "ailrk";
        };
      };
    };

    # Install packages
    home.packages = with pkgs;
    let
      common = [

        tmux
        direnv

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
        lemonbar
        acpi
        expect
        fd
        bat
        fzf
        git-crypt
        gnupg

        # font
        iosevka
        fira-code

        # languages
        smlnj
        ocaml
        racket
        python39Full
        lua
        haskellPackages.ghcup
        dotnet-sdk
        fsharp
        rebar3
        purescript
        rustup
        nodejs
        valgrind

        # Jokes
        cowsay
        fortune
        figlet
        lolcat
        nms
        rofi

        # others
        google-chrome
        blender
        xournalpp
        aseprite
        mupdf
        ncmpcpp
        zathura
        wireshark-qt
      ];

      linuxSpecifics = lib.optionals stdenv.isLinux [
        # Data, Files and Networking
        sshfs
        iotop
        fio
      ];

      unfree = [
        discord
        tdesktop
      ];

    in
    common ++ linuxSpecifics ++ unfree;
  };
}
