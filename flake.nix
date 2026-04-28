{
  description = "Kirby Home Manager Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl.url = "github:guibou/nixGL";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs: {
    homeConfigurations = {
      "fatmonad" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./machine/linux_x86_fatmonad.nix
          sops-nix.homeManagerModules.sops
          {
            kirby.home.linux_x86.fatmonad = {
              enable = true;
              colorMode = "light";
            };
          }
        ];
      };

      "ailrk" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./machine/linux_m1_ailrk.nix
          sops-nix.homeManagerModules.sops
          {
            kirby.home.linux_m1.ailrk = {
              enable = true;
              colorMode = "light";
            };
          }
        ];
      };
    };
  };
}
