{ pkgs, ... }: {
  xsession.enable = true;
  xsession.profileExtra = ''
    eval $(${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --daemonize --components=ssh,secrets)
    export SSH_AUTH_SOCK
  '';
  xsession.windowManager.i3 = rec {
    enable = true;
    package = pkgs.i3-gaps;

    config.gaps = {
      top = 0;
      left = 0;
      right = 0;
      bottom = 0;
      #smartBorders = "on";
      #smartGaps = true;
    };

    config = {

      modifier = "Mod4"; # super

      keybindings = import ./i3-keybindings.nix config.modifier;

      # janky workaround for xkb issues
      startup = [{ command = ''exec setxkbmap -option "ctrl:swapcaps"''; }];

    };

    extraConfig = ''
      for_window [class=".*"] border pixel 0
    '';

  };
}
