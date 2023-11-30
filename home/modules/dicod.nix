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

    configPath = mkOption {
      type = types.path;
      default = ""; # /etc/dicod.conf
    };

    accessLogDir = mkOption {
      type = types.path;
      default = config.xdg.configHome;
    };

  };


  config = mkIf cfg.enable
    (
      let
        # NB `joined` must be extracted to `let...in` or else passing it to
        # `home.packages` throws a type error (doesn't see `joined` as a package)
        dictlist = map
          (x: {
            name = x.name;
            filename = x;
          })
          cfg.packages;


        joined = pkgs.symlinkJoin {
          name = "joined-dicod-dicts";
          paths = cfg.packages;
        };

        collected = pkgs.dictsCollector {
          enableGcide = true;
          accessLogDir = cfg.accessLogDir;
          inherit dictlist;
          dbDir = "${joined}/share/dictd";
        };

      in
      {

        # - Enable service dicod

        systemd.user.services =
          {
            dicod = {
              Unit = { Description = "GNU Dico DICT server"; };
              Service = {
                # docker run --name="dicod" --rm -d -p2628 beryj7/dicod-docker:latest
                ExecStart = "${pkgs.dico}/bin/dicod -f --config=${collected}/share/dicod/dicod.conf";
              };
              Install = { WantedBy = [ "default.target" ]; };
            };
          };

        # - enable all packages in list
        home.packages = [ pkgs.dico joined ];

        # TODO handle all dico related packages, including dict-db
        # - add handler 
        # - add gcide to pkgs.dicts, then possibly just use dictd


      });


  }
