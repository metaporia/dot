final: prev:

let 
      system = prev.system;
      pkgArchive = prev.callPackage import (builtins.fetchGit {
# Descriptive name to make the store path easier to identify
      name = "archived_love_0_7";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "f76bef61369be38a10c7a1aa718782a60340d9ff";
  }) { inherit system; };

in 

{
  nottetris2 = pkgArchive.nottetris2;

  # Uses fork at gitlab.com/metaporia/not-tetris with dvorak-friendly bindings.
  #nottetris2 = import ./nottetris2.nix {pkgs=prev;};
}
