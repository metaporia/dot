{ pkgs ? import <nixpkgs> {} }:

{
  nottetris2 = pkgs.callPackage ./nottetris2.nix { };
}
