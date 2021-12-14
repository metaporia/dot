{
  description = "metaporia's attempt at a flake-based NixOS configuration";

  # Nix Flakes Resources
  # - minimal example: https://github.com/colemickens/nixos-flake-example
  # - hlissner's dotfiles: https://github.com/hlissner/dotfiles
  # - tweag.io article on NixOS managament with flakes: https://www.tweag.io/blog/2020-07-31-nixos-flakes/

  # Rebuild system with `cd ~/dot; sudo nixos-rebuild switch --flake '.#kerfuffle"`

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      kerfuffle = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager {
            # Use system pkgs for hm; disables nixpkgs.* options in ./home.nix.
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            nixpkgs.overlays = (import ./nix-overlays);
            home-manager.users.aporia = import ./home.nix;

          }
        ];
      };
    };
  };
}
