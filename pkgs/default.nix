{ pkgs ? import <nixpkgs> { } }:
rec {
  croissant = pkgs.luaPackages.callPackage ./croissant.nix {
    inherit sirocco;
    inherit hump;
  };

  sirocco = pkgs.luaPackages.callPackage ./sirocco.nix {
    inherit hump; inherit wcwidth;
  };
  hump = pkgs.callPackage ./hump.nix { };
  wcwidth = pkgs.luaPackages.callPackage ./wcwidth.nix { };
}
