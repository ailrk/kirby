{
  imports = [
    ./ailrk/default.nix
  ];

  # User specific overlays.
  nixpkgs.overlays = [

    # neovim nightly
    # (import (builtins.fetchTarball {
    #    url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    # }))

    # discord
    (self: super: {
      discord = super.discord.overrideAttrs (_: {
        src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;
      });
    })

    # END
  ];
}
