{
  description = "metaporia's attempt at a flake-based NixOS configuration";

  # Nix Flakes Resources
  # - minimal example: https://github.com/colemickens/nixos-flake-example
  # - hlissner's dotfiles: https://github.com/hlissner/dotfiles
  # - tweag.io article on NixOS managament with flakes: https://www.tweag.io/blog/2020-07-31-nixos-flakes/

  # Rebuild system with `cd ~/dot; sudo nixos-rebuild switch --flake '.#kerfuffle"`

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    scripts.url = "gitlab:metaporia/scripts";
    scripts.inputs.nixpkgs.follows = "nixpkgs";

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    hyprswitch.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , home-manager
    , anyrun
    , nixos-hardware
    , nix-index-database
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # from hlissner's dotfiles--redundant?

        # marked insecure; see issue: CVE-2024-27297
        config.permittedInsecurePackages = [
          "nix-2.16.2"
        ];

        # Alternatively, overlays can be specified in the NixOS home-manager
        # module as follows:
        # > nixpkgs.overlays = (import ./overlays); # ++ [scriptsOverlay]
        overlays = (import ./overlays.nix);
      };
      scripts = inputs.scripts.packages.${system};
      # fancy (that is, usable) lua repl
      croissant = (pkgs.callPackage ./pkgs {}).croissant;
      # TODO use flake-compat to apply overlays for nix-* tools
    in
    {
      # add legacyPackages: expose package set nixpkgs // overlays for
      # nix-update
      # from https://github.com/jtojnar/nixfiles : flake.nix
      inherit croissant;
      legacyPackages.x86_64-linux = pkgs;
      # expose standalone home configuration for `nixd`
      homeConfigurations.aporia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/aporia.nix ];
        extraSpecialArgs = {
          inherit inputs system;
        };
      };
      nixosConfigurations = {
        kerfuffle = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit system;
          modules = [
            # for nixos-hardware framework profile
            {
              services.fwupd.enable = true;
              # stable BIOS versions are marked as test versions
              services.fwupd.extraRemotes = [ "lvfs-testing" ];
              # Might be necessary once to make the update succeed
              services.fwupd.uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
            }
            nixos-hardware.nixosModules.framework-11th-gen-intel

            ./system/configuration.nix

            home-manager.nixosModules.home-manager
            {
              # Use system pkgs for hm; disables nixpkgs.* options in
              # ./home/aporia.nix.
              home-manager = {

                # Instead of letting the module system pass `pkgs` and `config` to
                # `./home/aporia.nix`, we can specify them ourselves like so:
                #
                # ```
                # home-manager.users.aporia = import ./home/aporia.nix {
                #   inherit pkgs;
                #   config = pkgs.config;
                # };
                # ```
                users = {
                  aporia.imports = [ ./home/aporia.nix ];
                  test.imports = [ ./home/test.nix ];
                };

                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";

                extraSpecialArgs = { inherit inputs scripts croissant; };

                sharedModules = [

                  # checks for system toggle: `mine.wm.hyprland` and loads
                  # appropriate modules. 
                  ./modules/home/wm.nix

                  nix-index-database.hmModules.nix-index
                  #anyrun.homeManagerModules.default
                ];
              };

              # Pass augmented nixpkgs to all modules.
              #
              # Our customized package set won't be used by home-manager without
              # this (or at least the pkgs.config won't be passed along).
              nixpkgs.pkgs = pkgs;


            }
          ];
        };
      };
    };
}
