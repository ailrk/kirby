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
    home.packages = with pkgs;
    let
      common = [
        tmux

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
      ];

      linux = lib.optionals stdenv.isLinux [
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
      ];

      unfree = lib.optionals stdenv.isLinux [
        tdesktop
        discord
      ];

    in
    common ++ linux ++ unfree;

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
