{ pkgs, lib, ... }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "ugdb";
  version = "0.1.12";

  src = pkgs.fetchFromGitHub {
    owner = "ftilde";
    repo = "ugdb";
    rev = "${version}";
    sha256 = "sha256-6mlvr/2hqwu5Zoo9E2EfOmyg0yEGBi4jk3BsRZ+zkN8=";
  };

  doCheck = false;

  cargoHash = "sha256-+J4gwjQXB905yk4b2GwpamXO/bHpwqMxw6GsnusbJKU=";

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/ugdb --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.gdb ]}
  '';
}
