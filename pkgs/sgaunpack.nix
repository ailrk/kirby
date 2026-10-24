{ haskellPackages, fetchFromGitHub, lib }:

let
  src = fetchFromGitHub {
    owner = "ailrk";
    repo = "sgaunpack";
    rev = "master";
    hash = "sha256-pInss1PrM7DXTgqsL6CdabCdnEWaqqU5nl8NcZk88U0=";
  };
in
haskellPackages.callCabal2nix "sgaunpack" src { }
