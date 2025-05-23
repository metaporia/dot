{ pkgs, ... }: ''
  # hyprland.conf
  #
  #
  # TODO:
  # - [x] notification daemon, e.g., dunst, mako, swaync
  #   - swaync
  # - [x] widgets/gui interface for audio, network, bluetooth
  # - [x] check whether xdg desktop portal works (for file pickers0
  # - [ ] authentication agent
  # - [x] qt5 wayland support (necessary?)
  #
  # - [x] clipboard manager (tmux, nvim integration)
  #
  # - [x] get function keys working
  # - [ ] app launcher/command palette
  # - [ ] wallpaper
  # - [x] fix kitty italic font clipping
  #
  # - [ ] nix just for labelled build, garbage collect, toggle linked config file
  #   (from table of fish, tmux, nvim, etc, with rebuild & preserve toggle state)

  # See https://wiki.hyprland.org/Configuring/Monitors/
  # monitor=name,resolution,position,scale
  monitor=,preferred,auto,1.33333

  # See https://wiki.hyprland.org/Configuring/XWayland/
  xwayland {
    force_zero_scaling = true
  }

  env = GDK_SCALE,2


  # See https://wiki.hyprland.org/Configuring/Keywords/ for more

  # Execute your favorite apps at launch
  #exec-once = waybar & hyprpaper & firefox
  exec-once = waybar & swaync
  exec-once=wl-clip-persist --clipboard both

  # Source a file (multi-file configs)
  # source = ~/.config/hypr/myColors.conf

  # Set programs that you use
  $terminal = kitty
  $fileManager = dolphin
  $browser = firefox
  $menu = wofi --show drun

  # Some default env vars.
  env = XCURSOR_SIZE,24
  env = QT_QPA_PLATFORMTHEME,qt6ct # change to qt6ct if you have that

  # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
  input {
      kb_layout=us
      kb_variant=dvorak
      kb_options=caps:ctrl_modifier
      kb_rules =

      follow_mouse = 1

      touchpad {
          natural_scroll = true
      }

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
  }

  general {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      gaps_in = 1
      gaps_out = 1
      border_size = 1
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)

      resize_on_border = 1
      extend_border_grab_area = 1

      layout = dwindle

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false
  }

  decoration {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      rounding = 0

      blur {
          enabled = true
          size = 3
          passes = 1
          
          vibrancy = 0.1696
      }

      drop_shadow = true
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
  }

  animations {
      enabled = true

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
  }

  dwindle {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true # you probably want this
  }

  master {
      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      new_is_master = true
  }

  gestures {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      workspace_swipe = false
  }

  misc {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      force_default_wallpaper = 1 # Set to 0 or 1 to disable the anime mascot wallpapers
  }

  # Example per-device config
  # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
  device {
      name = epic-mouse-v1
      sensitivity = -0.5
  }

  # Example windowrule v1
  # windowrule = float, ^(kitty)$
  # Example windowrule v2
  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
  windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.

  # Audio keybinds
  binde=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  binde=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ 
  binde=, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%- 
  binde=, XF86AudioNext, exec, playerctl next
  binde=, XF86AudioPrev, exec, playerctl previous
  binde=, XF86AudioPlay, exec, playerctl play-pause
  binde=, XF86AudioStop, exec, playerctl play-pause

  # Brightness
  binde = , XF86MonBrightnessUp, exec, brightnessctl s +5%
  binde = , XF86MonBrightnessDown, exec, brightnessctl s 5%-

  # print screen

  # See https://wiki.hyprland.org/Configuring/Keywords/ for more
  $mainMod = SUPER

  $altMod = ALT_L

  bind = $altMod, space, exec, anyrun

  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
  bind = $mainMod, Q, exec, $terminal
  bind = $mainMod, F, exec, $browser
  bind = $mainMod, C, killactive,
  #bind = $mainMod, M, exit,
  bind = $mainMod, E, exec, $fileManager
  bind = $mainMod, V, togglefloating,
  bind = $mainMod, R, exec, $menu
  bind = $mainMod, P, pseudo, # dwindle
  bind = $mainMod, J, togglesplit, # dwindle

  # Temporary QOL binds from personal gnome shortcuts

  bind = $altMod, M, fullscreen

  bind = ALT, Tab, cyclenext,
  bind = ALT, Tab, bringactivetotop,
  bind = ALT Shift, Tab, cyclenext, previous
  bind = ALT Shift, Tab, bringactivetotop,

  # Move focus with mainMod + arrow keys
  bind = $mainMod, left, movefocus, l
  bind = $mainMod, right, movefocus, r
  bind = $mainMod, up, movefocus, u
  bind = $mainMod, down, movefocus, d

  # Switch workspaces with mainMod + [0-9]
  bind = $mainMod, 1, workspace, 1
  bind = $mainMod, 2, workspace, 2
  bind = $mainMod, 3, workspace, 3
  bind = $mainMod, 4, workspace, 4
  bind = $mainMod, 5, workspace, 5
  bind = $mainMod, 6, workspace, 6
  bind = $mainMod, 7, workspace, 7
  bind = $mainMod, 8, workspace, 8
  bind = $mainMod, 9, workspace, 9
  bind = $mainMod, 0, workspace, 10

  # Move active window to a workspace with mainMod + SHIFT + [0-9]
  bind = $mainMod SHIFT, 1, movetoworkspace, 1
  bind = $mainMod SHIFT, 2, movetoworkspace, 2
  bind = $mainMod SHIFT, 3, movetoworkspace, 3
  bind = $mainMod SHIFT, 4, movetoworkspace, 4
  bind = $mainMod SHIFT, 5, movetoworkspace, 5
  bind = $mainMod SHIFT, 6, movetoworkspace, 6
  bind = $mainMod SHIFT, 7, movetoworkspace, 7
  bind = $mainMod SHIFT, 8, movetoworkspace, 8
  bind = $mainMod SHIFT, 9, movetoworkspace, 9
  bind = $mainMod SHIFT, 0, movetoworkspace, 10

  # Example special workspace (scratchpad)
  bind = $mainMod, S, togglespecialworkspace, magic
  bind = $mainMod SHIFT, S, movetoworkspace, special:magic

  # Scroll through existing workspaces with mainMod + scroll
  bind = $mainMod, mouse_down, workspace, e+1
  bind = $mainMod, mouse_up, workspace, e-1

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow
''
