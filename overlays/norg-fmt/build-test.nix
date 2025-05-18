{ pkgs ? import <nixpkgs> { } }:

{
  norg-fmt = pkgs.callPackage ./norg-fmt.nix { };
}
