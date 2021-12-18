{ config, lib, pkgs, ... }:
# TODO
# - ssh-agent (i think we need gnome keyring
{
  services.xserver = {
    enable = true;

    # Enable the X11 windowing system.
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [ dmenu ];
    };

    #enableCtrlAltBackspace = true;

    displayManager = { defaultSession = "none+i3"; };

    # Enable touchpad see `man libinput` for more options
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        tapping = true;
        naturalScrolling = true;
        additionalOptions = ''
          Option "PalmDetection" "True"
        '';
      };

    };

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "ctrl:swapcaps";

    #desktopManager = { default = "none"; };

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

  };

}

