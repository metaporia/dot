{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # forcefully kill X
    enableCtrlAltBackspace = true;

    # Enable touchpad see `man libinput` for more options
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        tapping = true;
      };
    };

    displayManager = {
      lightdm = {
        enable = true;
        greeter.enable = false;
      };
      autoLogin = {
        enable = true;
        user = "aporia";
      };
    };

    # Enable the GNOME Desktop Environment.
    autorun = true;
    desktopManager.gnome = {
      enable = true;
    };

  };

}
