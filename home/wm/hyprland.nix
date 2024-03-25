# Hyprland migration:
# - factor out X11 config
# - So, the hyprland nixos module must be enabled which fragments the config
#   and makes it harder to segregate hyprland config from X/gnome config.
#
#   A special config flag could be passed via specialArgs (I think) or
#   flake-parts, though massively overkill, would work.
{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    #package = pkgs.hyprland;

    xwayland.enable = true;

    # enable hyprland-session.target on hyprland startup
    systemd.enable = true;
    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "dvorak";
        kb_options = "caps:ctrl_modifier";
      };
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, firefox"
          "$mod, T, exec, kitty"
          "ALT_L, T, exec, kitty"
        ];
    };
  };

  programs.waybar.enable = true;

}
