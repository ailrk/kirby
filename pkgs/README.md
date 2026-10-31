How to create your own package?

Say you want this package. Note you don't have the hash yet, nix needs to compute the hash for you. So you first supply a `lib.fakeHash`.

```
{ pkgs, lib, ... }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "ugdb";
  version = "0.1.12";

  src = pkgs.fetchFromGitHub {
    owner = "ftilde";
    repo = "ugdb";
    rev = "${version}";
    sha256 = lib.fakeHash;
  };

  doCheck = false;

  cargoHash = lib.fakeHash;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/ugdb --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.gdb ]}
  '';
}
```

Then run `home-manager switch`. The build will fail, and nix will tell you the hash it's expecting.

```
error: hash mismatch in fixed-output derivation '/nix/store/jjkg3bns0cq0pnyh7as15k5sbw8fqh2d-source.drv':
         specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
            got:    sha256-6mlvr/2hqwu5Zoo9E2EfOmyg0yEGBi4jk3BsRZ+zkN8=
```

Simply copy the hash, this is the hash that nix will use to compare to on the next build. It makes sure the version of this package is pinned to this exact content.


When a program is built in nix, it lives strictly in `/nix/store`. If it needs any other tools to function, it will not just find them because there is no universal `/usr/bin`, the tool it depends on will live somewhere else in `/nix/store`.

To specify dependencies, we usually use `makeWrapper`. It is a handy nix tool that helps you to wrap a tool with an environment set up for it to find its dependencies. In this case, `ugdb` depends on `gdb`, so we need to specify that.
