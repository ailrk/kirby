{
  imports = [
    ./ailrk/default.nix
  ];

  # User specific overlays.
  nixpkgs.overlays = [

    # neovim nightly
    (import (builtins.fetchTarball {
       url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))

    # END
  ];
}
