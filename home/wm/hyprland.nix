# Hyprland migration:
# - factor out X11 config
# - So, the hyprland nixos module must be enabled which fragments the config
#   and makes it harder to segregate hyprland config from X/gnome config.
#
#   A special config flag could be passed via specialArgs (I think) or
#   flake-parts, though massively overkill, would work.

# see https://wiki.archlinux.org/title/Hyprland

# -mdepends on scripts/raise_dots
{ config, inputs, pkgs, ... }:
{

  imports = [ ../programs/anyrun.nix ];

  # see https://www.funtoo.org/OpenSSH_Key_Management,_Part_1
  programs.keychain = {
    enable = true;
    enableFishIntegration = true;
    keys = [ "github" "gitlab" ];
    extraFlags = [
      # use ~/.ssh/config IdentityFile to map keys names to paths
      "--confhost"
      "--quiet"

    ];
  };


  programs.ssh = {
    enable = true;
  };


  #home.file.".config/hypr/hyprland.conf".source = ../config/hyprland.conf;
  home.packages = with pkgs; [
    #hyprcursor
    # Wayland

    # clipboard
    wl-clipboard
    wl-clip-persist
    wl-clipboard-x11 # for neovim/tmux compatibility

    # authentication agent
    polkit-kde-agent

    wev
    swaynotificationcenter
    playerctl
    brightnessctl
    pavucontrol

    dolphin

    # hyprland specific

    # window switcher
    inputs.hyprswitch.packages.${system}.default

    # swaync
    libnotify

    # for wl_raise_dots
    #ydotool

  ];

  #programs.ydotool = { enable = true; };
  #users.users.aporia.extraGroups = [ "ydotool" ];


  # hyprswitch
  xdg.configFile."hypr/hyprswitch.css".source = ./hyprswitch.css;

  # waybar

  xdg.configFile."waybar/config".source = ../programs/waybar/config;
  # wants swaync
  programs.waybar = {
    enable = true;
    #settings = { };
  };

  services.swaync = {
    enable = true;
    #style = '' '';

  };


  wayland.windowManager.hyprland = {
    enable = true;
    #package = pkgs.hyprland;

    xwayland.enable = true;

    # enable hyprland-session.target on hyprland startup
    # unclear what this does
    systemd.enable = true;

    extraConfig = builtins.readFile ./hyprland.conf;

    # kbd layout set from ../../config/hyprland.conf
    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "dvorak";
        kb_options = "caps:ctrl_modifier";
      };
    };
    #  "$mod" = "SUPER";
    #  bind =
    #    [
    #      "$mod, F, exec, firefox"
    #      "$mod, T, exec, kitty"
    #      "ALT_L, T, exec, kitty"
    #    ];
    #};
  };


}


