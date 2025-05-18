# # Make gnome keyboard shortcuts toggleable
#{ config, lib, pkgs, ... }:
#
#with lib;
#
#let cfg = config.gnome-kbd-shortcuts;
#in
#{
#  # TODO idk whether this is the best idea. ideally, in configuration.nix
#  # the choice wm/gnome.nix or wm/xmonad.nix fully enables or disables their
#  # respective configs, including gnome shortcuts
#
#  imports = {
#  };
#
#  # declare options
#  options = {
#    gnome-kbd-shortcuts = {
#      enable = mkOption {
#        type = types.bool;
#        default = false;
#        description = "Whether to enable Keane's persnoal gnome keyboard shorcuts";
#      };
#    };
#
#  };
#
#  # define options
#  config = mkIf cgf.enable {
{
  dconf.settings = {

    "org/gtk/settings/debug" = { enable-inspector-keybinding = true; };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = let
        numberOfCustomKeybindings = 5;
        prefix =
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom";
        upTo = n:
          let go = acc: if acc == n then [ n ] else [ acc ] ++ go (acc + 1);
          in go 0;
        # NB: update as keybindings are added
      in builtins.map (x: prefix + builtins.toString x + "/")
      (upTo (numberOfCustomKeybindings - 1));
    };

    "org/gnome/desktop/wm/keybindings" = { toggle-maximized = [ "<Alt>m" ]; };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Primary><Alt>t";
        command = "/home/aporia/scripts/raise_tmux";
        name = "raise_tmux";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
      {
        binding = "<Primary><Alt>w";
        command = "/home/aporia/scripts/raise_primary_web";
        name = "raise primary web";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
      {
        binding = "<Primary><Alt>s";
        command = "/home/aporia/scripts/raise_secondary_web";
        name = "raise secondary web";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" =
      {
        binding = "<Primary><Alt>p";
        command = "/home/aporia/scripts/raise_vlc";
        name = "raise vlc";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" =
      {
        binding = "<Primary><Alt>g";
        command = "/home/aporia/scripts/raise_not_tetris";
        name = "raise not tetris";
      };

    # View split on left, right
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Primary><Alt>h" ];
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-right = [ "<Primary><Alt>l" ];
    };

    "org/gnome/desktop/interface" = { gtk-key-theme = "Emacs"; };

    "org/gnome/desktop/peripherals/touchpad" = { tap-to-click = true; };

    # remember to set firefox's layout.css.devPixelsPerPx to match
    "org/gnome/desktop/interface" = { text-scaling-factor = 1.4; };

  };
}

#  };
#}
