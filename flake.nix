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
    scripts.url = "gitlab:metaporia/scripts";
    scripts.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, scripts, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # from hlissner's dotfiles--redundant?

        # Alternatively, overlays can be specified in the NixOS home-manager
        # module as follows:
        # > nixpkgs.overlays = (import ./nix-overlays); # ++ [scriptsOverlay]
        overlays = [ scripts.overlay ] ++ (import ./nix-overlays);
      };
    in {
      nixosConfigurations = {
        kerfuffle = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              # Use system pkgs for hm; disables nixpkgs.* options in
              # ./home/aporia.nix.
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Pass augmented nixpkgs to all modules.
              #
              # Our customized package set won't be used by home-manager without
              # this.
              #
              # I believe it would otherwise default to the `nixpkgs.config` (?)
              # of the `nixpkgs` in scope.
              nixpkgs.pkgs = pkgs;

              # Instead of letting the module system pass `pkgs` and `config` to
              # `./home/aporia.nix`, we can specify them ourselves like so:
              #
              # ```
              # home-manager.users.aporia = import ./home/aporia.nix {
              #   inherit pkgs;
              #   config = pkgs.config;
              # };
              # ```
              home-manager.users.aporia.imports = [ ./home/aporia.nix ];

            }
          ];
        };
      };
    };
}
