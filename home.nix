{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aporia";
  home.homeDirectory = "/home/aporia";

  home.packages = with pkgs; [
    dico
    alacritty
    docker
    scripts
    firefox
    exa
    fd
    ripgrep
    wmctrl
    xclip
    vlc
    tmux
    gnome.gnome-tweaks
    #chrome-gnome-shell
    #gnomeExtensions.hide-top-bar
    nixos-option
    git-lfs
    nottetris2
    nix-prefetch-git
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  #services.gnome3.chrome-gnome-shell.enable = true;
  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;

  #programs.firefox = {
  #  enable = true;
  #};

  #programs.firefox.package = pkgs.firefox.override {
  #  cfg = { enableGnomeExtensions = true; };
  #};


  # TODO so I noticed that my macbook's dict output had indentation sensitive
  # line-wrapping. Apparently dict-gcide's conversion of the *.CIDE files is
  # better than that of dico (who knew!); but in any case the data is a
  # shit-show, as we well know, and dict seems to handle it better. So, we
  # should switch from dico to dict (which may involve making a dict-gcide nix
  # package--see arch's dict-gcide), and then get back to work sanitizing that
  # damn dictionary (remember to update to 0.53--oh god the progress staled!).
  systemd.user.startServices = "sd-switch"; # requires dbus session
  systemd.user.services = {
      dicod = {
        Unit = {
          Description = "GNU Dico DICT server";
        };
        Service = {
          # docker run --name="dicod" --rm -d -p2628 beryj7/dicod-docker:latest
          ExecStart = "${pkgs.dico}/bin/dicod -f";
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
  };

  xdg.configFile."nix/nix.conf".source = ./nix.conf;

  ##########
  # NEOVIM #
  ##########

  # simplest method; just places ./nvim/ in ~/.config/
  # for some reason this breaks initial invocation of `home-manager switch`.
  # It seemed to work after neovim was installed already, however.
  #xdg.configFile."nvim" = {
  #  source = ./nvim;
  #  recursive = true;
  #};

    # Alternatively, use neovim module:
  # super jank: the above links in the whole ./nvim/ dir, while the below
  # overwrites ./nvim/init.vim with itself (ik, ik--it's a dumpster fire)
  # As yet vim-plug installs itself from init.vim, the downside being that it
  # updates plugin on VimEnter which will undoubtedly break shit at an
  # unopportune moment
  # TODO somehow add the rest of ./nvim (e.g., ftplugin &co)
  programs.neovim = {
    #package = pkgs.myNeovim; # how to override with vim-plug??
    enable = true;
    extraConfig = (builtins.readFile ./programs/nvim/init.vim);
  };

  imports = [

    (import ./gnome-kbd-shortcuts.nix) # enable gnome shortcuts
    #(import ./i3.nix)
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      bind \ea 'history-token-search-backward'
      bind \cs 'prepend_command sudo'
      #fish_add_path /home/aporia/scripts/
      set fish_greeting

      # colorize manpages
      set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
      set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
      set -x LESS_TERMCAP_me \e'[0m'           # end mode
      set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
      set -x LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
      set -x LESS_TERMCAP_ue \e'[0m'           # end underline
      set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
    '';

    functions = {
    prepend_command = ''
      set -l prepend $argv[1]
      if test -z "$prepend"
          echo "prepend_command needs one argument"
          return 1
      end

      set -l cmd (commandline)
      if test -z "$cmd"
          commandline -r $history[1]
      end

      set -l old_cursor (commandline -C)
      commandline -C 0
      commandline -i "$prepend "
      commandline -C (math $old_cursor + (echo $prepend | wc -c))
    '';

    };
    shellAbbrs = {
      cb = "cd -";
      g = "git";
      gs = "git status --short";
      gaa = "git add --all";
      ga = "git add";
      gau = "git add -u"; # stage modified, deleted, not new.;
      gcm = "git commit -m";
      gctt = "git commit -m 'Tiny tweaks.'";
      gp = "git p";
      gb = "git branch --all";
      gr = "git remote --verbose";
      gl = "git log --graph --oneline --decorate";
      gls = "git log --graph --oneline --decorate --stat";
      gd = "git diff";
      gdc = "git diff --cached";
      gca = "git commit --amend --no-edit";
      gg = "git pull";
      ta = "tmux attach -t";
      t = "tmux new -A -s"; # attach or create <sesh>
      tks = "tmux kill-session -t";
      ts = "tmux list-sessions";
      tp = "tmux list-panes";
      tw = "tmux list-windows";
      ti = "tmux info";
      vi = "nvim";
      vis = "vi -S sesh";
      magit = "nvim +MagitOnly";
      gc = "gcide -ne";
      m = "muse -c search ";
      mp = "muse parse";
      mu = "mupdf";
      open = "xdg-open";
    };
  };

  home.file = {

    ".tmux.conf".source = ./programs/tmux/tmux.conf;
    ".ssh/config".source = ./programs/ssh/sshconfig;
    ".config/gtk-3.0/gtk.css".source = ./gtk.css;
    # ".config/alacritty/alacritty.yml".source = "./alacritty.yml"

    #".config/fish/config.fish".source = ./config.fish;
    ".config/fish/functions/fish_prompt.fish".source = ./programs/fish/fish_prompt.fish;
    ".config/fish/functions/fish_title.fish".source = ./programs/fish/fish_title.fish;

    ".gitconfig".source = ./programs/git/gitconfig_global;
    "scripts" = {
      source = pkgs.fetchFromGitLab {
        owner = "metaporia";
        repo = "scripts";
        rev = "cd169e08dceb7e18fcf6ad799a77e4d9453ca42b";
        sha256= "1a4wms8l6fywj1m25cr2g5nw01mq0jkkapp0b11f749knynfsjar";
      };

    };

    ".dico".source = ./programs/dico/.dico;

  };

  programs.bat = {
    enable = true;
    config = { theme = "TwoDark"; };
  };

  #########
  # GNOME #
  #########

  #dconf.settings = {

  #  "org/gnome/settings-daemon/plugins/media-keys" = {
  #    custom-keybindings =
  #      let numberOfCustomKeybindings = 4;
  #          prefix = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom";
  #          upTo = n: let go = acc: if acc == n then [n] else [acc] ++ go (acc + 1); in go 0;
  #      # NB: update as keybindings are added
  #      in builtins.map (x: prefix + builtins.toString x + "/") (upTo
  #      (numberOfCustomKeybindings - 1));
  #    };

  #  "org/gnome/desktop/wm/keybindings" = {
  #    toggle-maximized=["<Alt>m"];
  #  };

  #  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
  #    binding = "<Primary><Alt>t";
  #    command = "/home/aporia/scripts/raise_tmux";
  #    name = "raise_tmux";
  #  };

  #  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
  #    binding = "<Primary><Alt>w";
  #    command = "/home/aporia/scripts/raise_primary_web";
  #    name = "raise primary web";
  #  };

  #  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
  #    binding = "<Primary><Alt>s";
  #    command = "/home/aporia/scripts/raise_secondary_web";
  #    name = "raise secondary web";
  #  };

  #  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
  #    binding = "<Primary><Alt>p";
  #    command = "/home/aporia/scripts/raise_vlc";
  #    name = "raise vlc";
  #  };

  #  # View split on left, right
  #  "org/gnome/mutter/keybindings" = {
  #    toggle-tiled-left = ["<Primary><Alt>h"];
  #  };

  #  "org/gnome/mutter/keybindings" = {
  #    toggle-tiled-right = ["<Primary><Alt>l"];
  #  };

  #  "org/gnome/desktop/interface" = {
  #    gtk-key-theme = "Emacs";
  #  };

  #  "org/gnome/desktop/peripherals/touchpad" = {
  #    tap-to-click = true;
  #  };

  #  # remember to set firefox's layout.css.devPixelsPerPx to match
  #  "org/gnome/desktop/interface" = {
  #    text-scaling-factor = 1.4;
  #  };



  #};



}
