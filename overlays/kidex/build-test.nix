{ pkgs ? import <nixpkgs> { } }:

{
  kidex = pkgs.callPackage ./kidex.nix { };
}
