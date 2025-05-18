# Load all overlays in directory. An overlay is expected to have one of two
# forms:
# - a directory containing a default.nix, e.g., ./my-overlay/default.nix; or,
# - a single file, e.g., ./my-overlay.nix

# NB. ./default.nix or ./auto.nix is excluded as it's the final overlay
let
  collectOverlays = with builtins;
    path:
    map (n: import (path + ("/" + n))) (filter (n:
      (match "[^.].*\\.nix" n != null && n != "default.nix")
      || pathExists (path + ("/" + n + "/default.nix")))
      (attrNames (readDir path)));

in collectOverlays ./overlays
