# handle wm swapping. This module is always imported.)
# TODO: is it possible for `options.mine.wm` to load this into home-manager?

{ osConfig, ... }:

{
  imports =
    (if osConfig.mine.wm.hyprland.enable then [ ../../home/wm/hyprland.nix ]
    else [ ]);
}
