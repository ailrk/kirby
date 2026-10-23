# common packages
{ pkgs, ... }:
let
  # Helper function to declare a PyPI package
  # format: setuptools|pyproject|wheel
  pypiTool = { name, version, format ? "setuptools", sha }:
  let
    src = pkgs.fetchurl {
      # Use the exact files.pythonhosted.org URL,
      # or point directly to the GitHub release/tag tarball:
      url = "https://files.pythonhosted.org/packages/source/${builtins.substring 0 1 name}/${name}/${builtins.replaceStrings ["-"] ["_"] name}-${version}.tar.gz";
      hash = sha;
    };
  in
    pkgs.python3Packages.buildPythonPackage {
      inherit version format src;
      pname = name;
    };
in
[
  pkgs.binutils

    # tools
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
    pkgs.sops
    pkgs.age
    pkgs.graphviz
    pkgs.ssh-to-age
    pkgs.pandoc
    pkgs.gnupatch
    pkgs.xterm
    pkgs.imagemagick
    pkgs.ntp
    pkgs.bandwhich
    pkgs.binsider
    pkgs.openssl
    pkgs.yq
    pkgs.jq
    pkgs.bcc
    pkgs.gum
    pkgs.glow
    pkgs.skate
    pkgs.nap
    pkgs.slides
    pkgs.chafa
    pkgs.graph-easy
    pkgs.confetty
    pkgs.p7zip

    # new core
    pkgs.rsync
    pkgs.eza
    pkgs.sd
    pkgs.pv
    pkgs.htop
    pkgs.inetutils
    pkgs.ripgrep
    pkgs.btop
    pkgs.killall
    pkgs.expect
    pkgs.fd
    pkgs.choose
    pkgs.bat
    pkgs.fzf
    pkgs.just

    # tui
    pkgs.regex-tui
    pkgs.systemctl-tui
    pkgs.nix-inspect
    pkgs.cgdb

    # nix
    pkgs.any-nix-shell
    pkgs.nixfmt

    # apps
    pkgs.awscli
    pkgs.opentofu
    pkgs.litellm
    pkgs.bottles
    pkgs.tree-sitter

    # langs
    pkgs.valgrind
    pkgs.gnumake
    pkgs.nixd
    pkgs.bash-language-server
    pkgs.typescript-language-server
    pkgs.cmake
    pkgs.nodejs
    pkgs.gcc
    pkgs.clang-tools
    pkgs.gdb
    pkgs.lld
    pkgs.bear
    pkgs.nasm
    pkgs.lua
    pkgs.lua-language-server
    pkgs.pyright
    (pkgs.python312.withPackages (ps: [
      ps.ipython
      ps.pygls
      ps.jieba
    ]))
    (pypiTool {
      name = "relic-tool-sga";
      version = "2.0.1";
      format = "wheel";
      sha = "sha256-ufp+Gu1wXedQ3eBiinOUbZXEFfo8RbhBvNUcCzaS64k=";
    })

    # font
    pkgs.fira-code
    pkgs.paratype-pt-mono
    pkgs.apl386
    pkgs.crimson-pro
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.font-awesome
    pkgs.terminus_font_ttf
    pkgs.wqy_microhei
    pkgs.liberation_ttf_v1
    pkgs.ultimate-oldschool-pc-font-pack
    pkgs.zpix-pixel-font
    pkgs.corefonts

    # nix
    pkgs.nix-tree
    pkgs.nix-visualize
    pkgs.nix-diff
    pkgs.nvd
    pkgs.nix-index

    # X
    pkgs.xset
    pkgs.xinput
    pkgs.brightnessctl
    pkgs.xdotool
    pkgs.xtitle
    pkgs.xdo
    pkgs.pinentry-curses
    pkgs.xclip
    pkgs.scrot
    pkgs.xscreenruler

    # wayland
    pkgs.cage
    pkgs.foot
    pkgs.swaybg
    pkgs.mpvpaper
    pkgs.wlr-randr
    pkgs.grim
    pkgs.slurp

    pkgs.libsixel
    pkgs.lsix
    pkgs.imagemagick

    pkgs.pinta
    pkgs.ibus
    pkgs.ibus-engines.pinyin
    pkgs.nautilus
    pkgs.libsForQt5.qt5.qttools
    pkgs.xournalpp
    pkgs.blueman
    pkgs.mupdf
    pkgs.zathura
    pkgs.font-manager
  ]
