alias b := build

build:
  NIXOS_LABEL=$(nixos-generate-label) nixos-rebuild switch \
  --use-remote-sudo  -v --flake '/home/aporia/dot#kerfuffle' --show-trace

update-firmware:
  fwupdmgr update
