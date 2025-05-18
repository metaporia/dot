{ pkgs ? import <nixpkgs> { } }:
let
  lib = pkgs.lib;
  dbs = with pkgs;
    map (x: {
      name = x.name;
      filename = x;
    }) [
      dictdDBs.wiktionary
      dictdDBs.wordnet
      dictdDBs.eng2rus

    ];
in {
  dicts = (pkgs.callPackage ./dicts-collector.nix { }) {
    enableGcide = true;
    accessLogDir = "logdir";
    dictlist = dbs;
    dbDir = "dbDir";
  };
}

