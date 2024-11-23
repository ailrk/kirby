# common packages
{ pkgs, ... }:
  [
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
    pkgs.lsof
    pkgs.tldr
    pkgs.w3m
    pkgs.sshfs
    pkgs.fio
    pkgs.acpi
    pkgs.ncmpcpp
    pkgs.lldb
    pkgs.qemu
    pkgs.direnv
    pkgs.just
    pkgs.sops
    pkgs.age
    pkgs.graphviz
    pkgs.ssh-to-age
    pkgs.pandoc
    pkgs.gnupatch
    pkgs.xterm
    pkgs.imagemagick

    pkgs.any-nix-shell

    pkgs.awscli
    pkgs.opentofu

    # langs
    pkgs.valgrind
    pkgs.gnumake
    pkgs.nil
    pkgs.nodePackages.bash-language-server
    pkgs.nodePackages.typescript-language-server
    pkgs.cmake
    pkgs.rustup
    pkgs.nodejs
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
    pkgs.python312Packages.ipython
    pkgs.pyright

    pkgs.fira-code
    pkgs.paratype-pt-mono
    pkgs.crimson-pro
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.font-awesome
    pkgs.wqy_microhei
    pkgs.liberation_ttf_v1

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

    pkgs.ibus
    pkgs.gnome.nautilus
    pkgs.libsForQt5.qt5.qttools
    pkgs.thunderbird
    pkgs.wireshark-qt
    pkgs.xournalpp
    pkgs.blueman
    pkgs.mupdf
    pkgs.zathura
    pkgs.font-manager
    pkgs.libsForQt5.filelight
  ]
