{ pkgs, ... }: {

  programs.kitty = {
    enable = true;
    # make terminal theme a bit light to differentiate from nvim panes
    themeFile = "tokyo_night_storm";
    shellIntegration.enableFishIntegration = true;
    settings = {
      startup_session = "~/.config/kitty/tmux_session.conf";
    };
    # TODO: cursor_smear 3 (or cursor_trail?)
    extraConfig = ''
      modify_font underline_thickness 150%
      modify_font underline_position 2
      font_family SauceCodePro Nerd Font Mono
      font_size 13
      initial_window_width  640
      initial_window_height 400
    '';
    settings = {
      cursor_shape = "beam";
    };
    keybindings = { };

  };
}
