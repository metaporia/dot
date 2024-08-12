{ pkgs, ... }: {

  programs.kitty = {
    enable = true;
    # make terminal theme a bit light to differentiate from nvim panes
    theme = "Tokyo Night Storm";
    shellIntegration.enableFishIntegration = true;
    settings = {
      startup_session = "~/.config/kitty/tmux_session.conf";
    };
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
