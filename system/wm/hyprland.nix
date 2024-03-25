# Hyprland migration:
# - factor out X11 config
{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

}
