{ pkgs ? import <nixpkgs> {} }:

{
  tree-sitter-latex = pkgs.callPackage ./tree-sitter.nix {};
}
