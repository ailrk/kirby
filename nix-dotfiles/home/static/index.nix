{ config, lib, ... }:
with
lib;
let
  cfg = config.elemental.home.static;

  images = {
    "dune" = ./images/dune.jpg;
    "girl-city-bg" = ./images/girl-city-bg.jpg;
    "pokebeach" = ./images/pokebeach.jpg;
  };

  fonts = {
  };
in
{

  options.elemental.home.static = {
    enable = mkEnableOption "Copying static assets";

    scriptFiles = mkOption {
      type = types.attrsOf types.path;
      default = { };
      description = "Some assets";
    };
  };


  config =
    let
      imagesFiles = mapAttrs'
      (n: v: nameValuePair "static/images/${n}" {
        source = v;
      })
      images;


      fontFiles = mapAttrs'
      (n: v: nameValuePair "static/fonts/${n}" {

      })
      fonts;

    in
    mkIf cfg.enable {
      xdg.configFile = imagesFiles // fontFiles;
    };
}

