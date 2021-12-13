# Run `nix-shell` in this directory to test overlay without invoking
# `home-manager switch`.
{pkgs ? import <nixpkgs> { overlays = [ (import ./default.nix) ]; }}:

  pkgs.mkShell {

    nativeBuildInputs = [pkgs.nottetris2];

}
