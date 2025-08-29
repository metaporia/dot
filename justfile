alias b := build

flake_attr := "/home/aporia/dot#kerfuffle"
rebuild_flags := "--verbose --show-trace"

default:
  just --choose

build: untoggle-hyprland hyprpanel-quit && hyprpanel-start
  NIX_SSHOPTS="-tt" NIXOS_LABEL=$(nixos-generate-label) \
  sudo nixos-rebuild switch {{rebuild_flags}} --flake {{flake_attr}} 


check FLAGS=rebuild_flags:
  nixos-rebuild dry-build {{FLAGS}} --flake {{flake_attr}}

update-firmware:
  fwupdmgr update

update-pkg PKG:
  nix-update --flake 'legacyPackages.x86_64-linux'.{{PKG}}


update-input FLAKE:
  nix flake update {{FLAKE}}

update:
  nix flake update

hyprpanel-quit:
  -hyprpanel --quit 
  -pkill swaync

hyprpanel-start:
  hyprpanel >/dev/null 2>&1 & disown

# Toggles


toggle-hyprland FLAGS='':
  toggle-link {{FLAGS }} ~/.config/hypr/hyprland.conf -s ~/dot/home/wm/hyprland.conf  && \
  hyprctl reload

untoggle-hyprland: (toggle-hyprland '--untoggle')

list-toggles:
  toggle-link --list

# Expects $DERIVATION to be a nix function returning a derivation in the current working dir

[no-cd]
build-derivation DERIVATION FLAGS='':
  nix build {{FLAGS}} --impure --expr "let pkgs = import <nixpkgs> {};  in pkgs.callPackage ./{{DERIVATION}} {}"

