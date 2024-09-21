{ lib, config, pkgs, ... }:
with lib;
let cfg = config.mine.wm.hyprland;
in
{
  options.mine.wm.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable hyprland window manager and associated NixOs and home-manager
        modules. This acts as a single unfied toggle for all things hyprland.
      '';
    };

    tag = mkEnableOption "tag system build";
    greetd = {
      enable = mkEnableOption "greetd service for hyprland";
      default-user = mkOption {
        type = types.str;
        default = "";
        description = "user for default session";
      };
    };

    # homeManagerModules = mkOption {
    #   type = types.listOf types.path;
    #   description = "List of paths to home-manager modules"
    # };


  };
  config = mkIf cfg.enable {
    # enable system module
    programs.hyprland.enable = true;
    system.nixos = mkIf cfg.tag { tags = [ "hypr" ]; };
    # enable greeter


    services.greetd = mkIf cfg.greetd.enable {
      enable = true;
      restart = false;
      settings = mkIf (cfg.greetd.default-user != "") {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = cfg.greetd.default-user;
        };
        initial_session = {
          command = "Hyprland";
          user = cfg.greetd.default-user;
        };
      };
    };

  };

}



