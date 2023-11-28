{ pkgs ? import <nixpkgs> { } }:
let lib = pkgs.lib;
in {
  dicts = pkgs.symlinkJoin {
    paths = lib.attrsets.attrValues (lib.recurseIntoAttrs (pkgs.callPackage
      ./dicts.nix
      { }));
    name = "joined-dicts";

  };
}
