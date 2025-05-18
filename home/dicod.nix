# FIXME WIP dicod config
{ pkgs, dico, ... }: {
  xdg.configFile."dicod.conf" = {
    text = pkgs.callPackage ./dicod-conf.nix { };
  };
}
