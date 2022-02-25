{ config, lib, ... }:

{
  imports = [
    ./lorri/default.nix
    ./mpd/default.nix
  ];
}
