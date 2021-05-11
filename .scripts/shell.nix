{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # add your dependencies for the shell
  inputsFrom = with pkgs; [];
  buildInputs = [];
}

