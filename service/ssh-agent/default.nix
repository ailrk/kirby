{ lib, ... }:
with
lib;
{
  options.kirby.services.ssh-agent = {
    enable = mkEnableOption "Enable bspwm window manager";
  };
}
