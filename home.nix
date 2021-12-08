{ config, pkgs, ... }:

with import <nixpkgs> {};

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aporia";
  home.homeDirectory = "/home/aporia";

  home.packages = with pkgs; [
    alacritty
    docker
    exa
    fd
    firefox
    ripgrep
    tmux
    vlc
    wmctrl
    xclip
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # TODO:
  # - add dicod-docker service with something like:
  #
  # systemd.user = {
  #   services = {
  #     dicod-docker = {
  #       Unit = { description = "Dockerized GNU Dico DICT server" };
  #       Service = {
  #         # docker run --name="dicod" --rm -d -p2628 beryj7/dicod-docker:latest
  #         ExecStart = "/home/aporia/scripts/dicod-docker";
  # 	    WantedBy = "multi-user.target";
  #       };
  #     };
  #   };
  # };

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
    extraConfig = (builtins.readFile ./nvim/init.vim);
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      bind \ea 'history-token-search-backward'
      bind \cs 'prepend_command sudo'
      fish_add_path /home/aporia/scripts/
      set fish_greeting
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

    ".tmux.conf".source = ./.tmux.conf.desk;
    # ".config/alacritty/alacritty.yml".source = "./alacritty.yml"

    #".config/fish/config.fish".source = ./config.fish;
    ".config/fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
    ".config/fish/functions/fish_title.fish".source = ./fish_title.fish;

    ".gitconfig".source = ./gitconfig_global;
    "scripts" = {
      source = fetchFromGitLab {
        owner = "metaporia";
        repo = "scripts";
        rev = "cd169e08dceb7e18fcf6ad799a77e4d9453ca42b";
      };

    };

  };

  ########
  # TMUX #
  ########

  programs.bat = {
    enable = true;
    config = { theme = "TwoDark"; };
  };



}
