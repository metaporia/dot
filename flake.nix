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
    , scripts
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
        overlays = [ scripts.overlay ] ++ (import ./my-overlays.nix);
      };
      # TODO use flake-compat to apply overlays for nix-* tools
    in
    {
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
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              #
              # Pass augmented nixpkgs to all modules.
              #
              # Our customized package set won't be used by home-manager without
              # this (or at least the pkgs.config won't be passed along).
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
              home-manager.users.test.imports = [ ./home/test.nix ];

              home-manager.extraSpecialArgs = { inherit inputs; };

              home-manager.sharedModules = [

                nix-index-database.hmModules.nix-index
                #anyrun.homeManagerModules.default
              ];

            }
          ];
        };
      };
    };
}
