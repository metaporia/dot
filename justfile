alias b := build

flake_attr := "/home/aporia/dot#kerfuffle"
rebuild_flags := "--verbose --show-trace"

default:
  just --choose

build: untoggle-hyprland
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


# Toggles

toggle-hyprland FLAGS='':
  toggle-link {{FLAGS }} ~/.config/hypr/hyprland.conf -s ~/dot/home/wm/hyprland.conf

untoggle-hyprland: (toggle-hyprland '--untoggle')

list-toggles:
  toggle-link --list
