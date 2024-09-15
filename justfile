alias b := build


build:
  NIX_SSHOPTS="-tt" NIXOS_LABEL=$(nixos-generate-label) nixos-rebuild switch \
  --use-remote-sudo  -v --flake '/home/aporia/dot#kerfuffle' --show-trace

update-firmware:
  fwupdmgr update

update-pkg PKG:
  nix-update --flake 'legacyPackages.x86_64-linux'.{{PKG}}

# TODO: untoggle before `build`
toggle-hyprland-conf:
  toggle-link ~/.config/hypr/hyprland.conf -s ~/dot/home/wm/hyprland.conf


update-input FLAKE:
  nix flake update {{FLAKE}}
