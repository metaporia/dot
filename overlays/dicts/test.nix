{ pkgs ? import <nixpkgs> { } }:
let lib = pkgs.lib;
in {
  dicts = pkgs.symlinkJoin {
    name = "joined-dicts";
    paths = lib.attrsets.attrValues
      (lib.recurseIntoAttrs (pkgs.callPackage ./dicts.nix { }));

  };
}
