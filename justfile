alias b := build

build:
  sudo nixos-rebuild switch  -v    --flake '/home/aporia/dot#kerfuffle' --show-trace

update-firmware:
  fwupdmgr update
