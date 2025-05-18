{ pkgs ? import <nixpkgs> { } }:

let
  # using nixpkgs revision before flake bump in April 2025
  # hopefully this works but idk--we may have to override some of the driver
  # libs and then it gets ugly. The alternative (short of finishing the rust
  # rewrite of nottetris) is to spin up a vm with gpu passthrough 
  pkgArchive = import (builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/574d1eac1c200690e27b8eb4e24887f8df7ac27c.tar.gz";
    sha256 = "sha256:0s6h7r9jin9sd8l85hdjwl3jsvzkddn3blggy78w4f21qa3chymz";
  }) { inherit (pkgs) system; };

  love_0_7 = pkgArchive.callPackage ./love_0_7.nix { lua = pkgArchive.lua5_1; };

  # pkgs = import (builtins.fetchGit { 
  #   name = "nixpkgs-old";
  #   url = "https://github.com/NixOS/nixpkgs/";
  #   rev = "574d1eac1c200690e27b8eb4e24887f8df7ac27c";
  #   ref = "refs/heads/nixos-unstable";
  #   # sha256 = "sha256-8S9n69Dnpg8DhfFlP0YvMGmSOY2X4kImGSPWXYNpaHM=";
  # }) {} ;
  #
  # name = "nottetris2";
  # src = pkgs.fetchFromGitHub {
  #     owner = "metaporia";
  #     repo = "nottetris2";
  #     rev = "dee1e1451ae38c6b4b5680b7fd41d2a289861b83";
  #     sha256 = "0rjlmvcm4c69yln0panj4p0mms5w6b0w5c5bnjrpmylkbgqncipy";
  # };

  # Used archive search tool described in this blog: 
  # - https://lazamar.github.io/download-specific-package-version-with-nix/
  # - https://lazamar.co.uk/nix-versions/?package=love&version=0.7.2&fullName=love-0.7.2&keyName=love_0_7&revision=f76bef61369be38a10c7a1aa718782a60340d9ff&channel=nixpkgs-unstable#instructions

  #   pkgArchive = import (builtins.fetchGit {
  # # Descriptive name to make the store path easier to identify
  #       name = "archived_love_0_7";
  #       url = "https://github.com/NixOS/nixpkgs/";
  #       ref = "refs/heads/nixpkgs-unstable";
  #       rev = "f76bef61369be38a10c7a1aa718782a60340d9ff";
  #   }) {};

  # love_0_7 = pkgArchive.love_0_7;

  # in pkgs.writeShellScriptBin name ''
  # exec ${love_0_7}/bin/love "${src}/Not Tetris 2.love"
  # ''

in {

  nottetris2 = pkgs.callPackage ./nottetris2.nix { inherit love_0_7; };

}
