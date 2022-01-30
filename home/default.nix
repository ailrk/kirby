{ config, lib, ... }:
{
  imports = [
    ./machine/default.nix
    ./program/default.nix
    ./role/default.nix
    ./user/default.nix
  ];

  manual.manpages.enable = false;
}
