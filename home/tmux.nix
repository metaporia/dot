{pkgs, scripts, ... }: {
  # TMUX

  # Add tmux session so that kitty always runs tmux on startup unless overriden
  # with the `--session` option.
  xdg.configFile."kitty/tmux_session.conf".text = ''
    launch tmux
  '';

  #home.file.".tmux.conf".source = ../config/tmux/tmux.conf;

  programs.tmux =
    let
      tmux-nvim =
        pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux.nvim";
          version = "unstable-2023-01-06";
          src = pkgs.fetchFromGitHub {
            #name = "tmux.nvim";
            owner = "aserowy";
            repo = "tmux.nvim";
            rev = "65ee9d6e6308afcd7d602e1320f727c5be63a947";
            sha256 = "063bcqwxlk18ygmr34jqnl0f0yhwy2zjkj4z8x7nl8bc07x2vnln";
          };
          meta.homepage = "https://github.com/aserowy/tmux.nvim/";
        };
    in
    {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        { plugin = tmux-thumbs; 
          extraConfig = ''
            set -g @thumbs-key f
            set -g @thumbs-alphabet dvorak-homerow
            set -g @thumbs-command 'echo -n {} | xclip -i -selection clip'
          '';
        }
        {
          plugin = tokyo-night-tmux;
          extraConfig = ''
            set -g @tokyo-night-tmux_show_music 0

            # battery
            set -g @tokyo-night-tmux_show_battery_widget 0
            #set -g @tokyo-night-tmux_battery_name "BAT2"  # some linux distro have 'BAT0'
            #set -g @tokyo-night-tmux_battery_low_threshold 21 # default

            set -g @tokyo-night-tmux_show_wbg 0
            set -g @tokyo-night-tmux_show_netspeed 0
            set -g @tokyo-night-tmux_show_git 0
          '';
        }
        {
          plugin = tmux-nvim;
          extraConfig = ''
            set -g @tmux-nvim-navigation-keybinding-left 'M-h'
            set -g @tmux-nvim-navigation-keybinding-down 'M-j'
            set -g @tmux-nvim-navigation-keybinding-up 'M-k'
            set -g @tmux-nvim-navigation-keybinding-right 'M-l'

            # disable resize binds for now
            set -g @tmux-nvim-resize false


          '';
        }
        {
          plugin = resurrect;
          # use nvim-resession to populate nvim pane, so strip all arguments from
          # command in tmux_resurrect_*.txt 
          extraConfig = ''
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'

            resurrect_dir="$HOME/.tmux/resurrect"
            set -g @resurrect-dir $resurrect_dir
            set -g @resurrect-hook-post-save-all '${scripts.sets.misc-bash-utils}/bin/tmuxResurrectHook'
            set -g @resurrect-processes '"~nvim"'
          '';
        }
      ];
      extraConfig = builtins.readFile ../config/tmux/tmux.conf;
    };
}
