{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.dicod;
in
{

  options.services.dicod = {

    enable = mkEnableOption "dicod";

    packages = mkOption {
      # list of dict packages
      type = types.listOf types.package;
      #description = mdDoc "List of packages providing dictionaries in the DICT format";
      default = [ ];


    };

    make-handlers = mkEnableOption (mdDoc "make database handlers");

    # default to ${dicts}/share/dictd/dicod.conf
    configPath = mkOption {
      type = types.path;
      default = ""; # /etc/dicod.conf
    };

  };


  config = mkIf cfg.enable {

    # - Enable service dicod

    #systemd.user.services =
    #  {
    #    dicod = {
    #      Unit = { Description = "GNU Dico DICT server"; };
    #      Service = {
    #        # docker run --name="dicod" --rm -d -p2628 beryj7/dicod-docker:latest
    #        ExecStart = "${pkgs.dico}/bin/dicod -f
    #        --config=${config.home.homeDirectory}/.config/dicod.conf";
    #      };
    #      Install = { WantedBy = [ "default.target" ]; };
    #    };
    #  };

    # - enable all packages in list
    home.packages = let 
    joined = pkgs.symlinkJoin {
        name = "joined-dicod-dicts";
        paths = cfg.packages ;
      };
    in [ joined ];

    # TODO handle all dico related packages, including dict-db
    # - add handler 
    # - add gcide to pkgs.dicts, then possibly just use dictd


  };


}
