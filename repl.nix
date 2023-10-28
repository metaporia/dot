# repl.nix
# from https://nixos.wiki/wiki/Flakes

let
  flake = builtins.getFlake (toString ./.);
  nixpkgs = import <nixpkgs> { };
in
{ inherit flake; }
// flake
// builtins
// nixpkgs
// nixpkgs.lib
// flake.nixosConfigurations
