alias b := build

build:
  NIXOS_LABEL=$(nixos-generate-label) sudo nixos-rebuild switch  -v --flake '/home/aporia/dot#kerfuffle' --show-trace

update-firmware:
  fwupdmgr update
