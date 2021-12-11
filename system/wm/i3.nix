{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
      ];
  };

  services.xserver.displayManager = {
      defaultSession = "none+i3";
  };
}

    #enableCtrlAltBackspace = true;
