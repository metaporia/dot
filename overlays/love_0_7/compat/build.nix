{ pkgs ? import (fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  # Replace the sha256 with the correct hash after running once
  sha256 = "sha256:09dahi81cn02gnzsc8a00n945dxc18656ar0ffx5vgxjj1nhgsvy";
}) { } }:

{
  nixpkgs = pkgs;
  tetris = pkgs.callPackage ./love07-updated.nix { };
}
