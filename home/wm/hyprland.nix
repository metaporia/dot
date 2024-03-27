# Hyprland migration:
# - factor out X11 config
# - So, the hyprland nixos module must be enabled which fragments the config
#   and makes it harder to segregate hyprland config from X/gnome config.
#
#   A special config flag could be passed via specialArgs (I think) or
#   flake-parts, though massively overkill, would work.
{ config, pkgs, ... }:
{

  #home.file.".config/hypr/hyprland.conf".source = ../config/hyprland.conf;
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    #package = pkgs.hyprland;

    xwayland.enable = true;

    # enable hyprland-session.target on hyprland startup
    # unclear what this does
    systemd.enable = true;

    # kbd layout set from ../../config/hyprland.conf
    #settings = {
    #  input = {
    #    kb_layout = "us";
    #    kb_variant = "dvorak";
    #    kb_options = "caps:ctrl_modifier";
    #  };
    #  "$mod" = "SUPER";
    #  bind =
    #    [
    #      "$mod, F, exec, firefox"
    #      "$mod, T, exec, kitty"
    #      "ALT_L, T, exec, kitty"
    #    ];
    #};
  };

  programs.waybar.enable = true;

}
