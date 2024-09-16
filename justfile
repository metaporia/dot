alias b := build


build:
  NIX_SSHOPTS="-tt" NIXOS_LABEL=$(nixos-generate-label) nixos-rebuild switch \
  --use-remote-sudo  -v --flake '/home/aporia/dot#kerfuffle' --show-trace

update-firmware:
  fwupdmgr update

update-pkg PKG:
  nix-update --flake 'legacyPackages.x86_64-linux'.{{PKG}}


update-input FLAKE:
  nix flake update {{FLAKE}}


# Toggles

toggle-hyprland FLAGS='':
  toggle-link {{FLAGS }} ~/.config/hypr/hyprland.conf -s ~/dot/home/wm/hyprland.conf

untoggle-hyprland: (toggle-hyprland '--untoggle')

list-toggles:
  toggle-link --list
