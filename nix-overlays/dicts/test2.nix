{ pkgs ? import <nixpkgs> { } }:
let lib = pkgs.lib;
in {
  dicts =
    pkgs.lib.recurseIntoAttrs (pkgs.callPackage ./dicts.nix { });
}

