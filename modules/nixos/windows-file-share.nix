# Simple toggle to enable smbclient to fetch media from local windows share.
{ config
, lib
, pkgs
, ...
}:
with lib;
let cgf = config.mine.windows-file-share;
in
{

  options.mine.windows-file-share =
    {
      enable = mkEnableOption "samba windows file share service";
      host = mkOption {
        type = types.str;
        default = "";
        description = "Host or IP address of file server";
      };

      sharePath = mkOption {
        type = types.str;
        default = "";
        description = "Path to shared directory";
      };
    };

  config = mkIf cgf.enable
    {


      #mine.samba.enable = true;
      #services.samba.enable = true;

      # cifs share client

      # For mount.cifs, required unless domain name resolution is not needed.
      fileSystems."/mnt/share" = {
        device = "//${cgf.host}/${cgf.sharePath}";
        fsType = "cifs";
        options =
          let
            # this line prevents hanging on network split
            automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

          in
          # NB: remember to add windows login to /etc/nixos/smb-secrets
          [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
      };
    };


}
