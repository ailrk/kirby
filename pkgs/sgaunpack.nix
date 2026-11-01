{ haskellPackages, fetchFromGitHub, lib }:

let
  src = fetchFromGitHub {
    owner = "ailrk";
    repo = "sgaunpack";
    rev = "master";
    hash = "sha256-BxudpY9IEfyiekOGl6R60mQzfveXdQU4nBs94oCqL00=";
  };
in
haskellPackages.callCabal2nix "sgaunpack" src { }
