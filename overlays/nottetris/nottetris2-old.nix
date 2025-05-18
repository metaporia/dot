{ pkgs ? import <nixpkgs> { } }:

let
  name = "nottetris2";
  src = pkgs.fetchFromGitHub {
    owner = "metaporia";
    repo = "nottetris2";
    rev = "dee1e1451ae38c6b4b5680b7fd41d2a289861b83";
    sha256 = "0rjlmvcm4c69yln0panj4p0mms5w6b0w5c5bnjrpmylkbgqncipy";
  };

  # Used archive search tool described in this blog: 
  # - https://lazamar.github.io/download-specific-package-version-with-nix/
  # - https://lazamar.co.uk/nix-versions/?package=love&version=0.7.2&fullName=love-0.7.2&keyName=love_0_7&revision=f76bef61369be38a10c7a1aa718782a60340d9ff&channel=nixpkgs-unstable#instructions

  pkgArchive = import (builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "archived_love_0_7";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "f76bef61369be38a10c7a1aa718782a60340d9ff";
  }) { };

  love_0_7 = pkgArchive.love_0_7;

in pkgs.writeShellScriptBin name ''
  exec ${love_0_7}/bin/love "${src}/Not Tetris 2.love"
''
