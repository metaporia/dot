final: prev:

{
  # from nixpkgs/pkgs/top-level/all-packages.nix: 
  # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/top-level/all-packages.nix#L299
  dicts = prev.lib.recurseIntoAttrs (prev.callPackage ./dicts.nix { });
  dictsCollector = prev.callPackage ./dicts-collector.nix { };
}
