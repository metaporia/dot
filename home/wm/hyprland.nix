# Hyprland migration:
# - factor out X11 config
# - So, the hyprland nixos module must be enabled which fragments the config
#   and makes it harder to segregate hyprland config from X/gnome config.
#
#   A special config flag could be passed via specialArgs (I think) or
#   flake-parts, though massively overkill, would work.

# see https://wiki.archlinux.org/title/Hyprland
{ config, inputs, pkgs, ... }:
{

  #home.file.".config/hypr/hyprland.conf".source = ../config/hyprland.conf;
  home.packages = with pkgs; [
    # Wayland

    # clipboard
    wl-clipboard
    wl-clip-persist
    wl-clipboard-x11 # for neovim/tmux compatibility

    wev
    swaynotificationcenter
    playerctl
    brightnessctl

    # hyprland specific
  ];

  programs.waybar.enable = true;
  programs.anyrun = {
    enable = true;
    config = {
      # enable plugins via flake output or here?
      plugins =
        with inputs.anyrun.packages.${pkgs.system};
        [
          applications
          randr
          stdin
          symbols
          translate
          websearch
          dictionary
          kidex
        ];
      width = { fraction = 0.3; };
      x = { fraction = 0.5; };
      y = { fraction = 0.5; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;
    };

    extraConfigFiles = {

      "translate.ron".text = ''
        // <Anyrun config dir>/translate.ron
        Config(
          prefix: ":",
          language_delimiter: ">",
          max_entries: 3,
        )
      '';

      "shell.ron".text = ''
        // <Anyrun config dir>/shell.ron
        Config(
          prefix: ":sh",
          // Override the shell used to launch the command
          shell: bash,
        )
      '';

      "symbols.ron".text = ''
        // <Anyrun config dir>/symbols.ron
        Config(
          // The prefix that the search needs to begin with to yield symbol results
          prefix: "",
          // Custom user defined symbols to be included along the unicode symbols
          symbols: {
            // "name": "text to be copied"
            "shrug": "¯\\_(ツ)_/¯",
          },
          max_entries: 3,
        )
      '';

      "websearch.ron".text = ''
        Config(
          prefix: "?",
          // Options: Google, Ecosia, Bing, DuckDuckGo, Custom
          //
          // Custom engines can be defined as such:
          // Custom(:
          //   name: "Searx",
          //   url: "searx.be/?q={}",
          // )
          //
          // NOTE: `{}` is replaced by the search query and `https://` is 
          // automatically added in front.
          engines: [Google] 
        )
      '';
    };

    extraCss = ''
      @define-color bg-col  rgba(30, 30, 46, 0.7);
      @define-color bg-col-light rgba(150, 220, 235, 0.7);
      @define-color border-col rgba(30, 30, 46, 0.7);
      @define-color selected-col rgba(150, 205, 251, 0.7);
      @define-color fg-col #D9E0EE;
      @define-color fg-col2 #F28FAD;

      * {
        transition: 200ms ease;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 1.3rem;
      }

      #window {
        background: transparent;
      }

      #plugin,
      #main {
        border: 3px solid @border-col;
        color: @fg-col;
        background-color: @bg-col;
      }
      /* anyrun's input window - Text */
      #entry {
        color: @fg-col;
        background-color: @bg-col;
      }

      /* anyrun's ouput matches entries - Base */
      #match {
        color: @fg-col;
        background: @bg-col;
      }

      /* anyrun's selected entry - Red */
      #match:selected {
        color: @fg-col2;
        background: @selected-col;
      }

      #match {
        padding: 3px;
        border-radius: 16px;
      }

      #entry, #plugin:hover {
        border-radius: 16px;
      }

      box#main {
        background: rgba(30, 30, 46, 0.7);
        border: 1px solid @border-col;
        border-radius: 15px;
        padding: 5px;
      }
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    #package = pkgs.hyprland;

    xwayland.enable = true;

    # enable hyprland-session.target on hyprland startup
    # unclear what this does
    systemd.enable = true;

    extraConfig = pkgs.callPackage ./hyprland-conf.nix { };

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


