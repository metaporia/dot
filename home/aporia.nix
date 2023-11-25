{ pkgs, config, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aporia";
  home.homeDirectory = "/home/aporia";

  home.packages = with pkgs; [
    # DICO
    # TODO enable in dicod-conf module
    dicts.jargon
    dicts.moby-thesaurus
    dicts.foldoc
    dicts.devils

    dico
    dictdDBs.wordnet
    dictdDBs.wiktionary
    docker
    scripts
    firefox
    exa
    fd
    ripgrep
    hyperfine
    wmctrl
    xclip
    vlc
    tmux
    gnome.gnome-tweaks
    #chrome-gnome-shell
    #gnomeExtensions.hide-top-bar
    nixos-option
    git-lfs
    #nottetris2 # FIXME
    nix-prefetch-git
    nixpkgs-fmt
    # apps
    love_0_7
    nottetris2
    transmission-qt
    sqlitebrowser
    path-of-building
    libsForQt5.okular
    # lsps
    lua-language-server
    nil
    nixpkgs-fmt
    # cs19
    lldb_12
    clang_12
    llvmPackages_12.libcxx
    clang-tools_12
    sshfs
    cling
    gdb
    cmake # for nvim telescope fzf native extension
    zoom-us

  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

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
      Unit = { Description = "GNU Dico DICT server"; };
      Service = {
        # docker run --name="dicod" --rm -d -p2628 beryj7/dicod-docker:latest
        ExecStart = "${pkgs.dico}/bin/dicod -f --config=/home/aporia/.config/dicod.conf";
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };

  #xdg.configFile."nix/nix.conf".source = ../nix.conf;

  xdg.configFile."clangd/config.yaml".source = ../config/clangd-config.yaml;



  ##########
  # NEOVIM #
  ##########

  # Alternatively, use neovim module:
  # super jank: the above links in the whole ./nvim/ dir, while the below
  # overwrites ./nvim/init.vim with itself (ik, ik--it's a dumpster fire)
  # As yet vim-plug installs itself from init.vim, the downside being that it
  # updates plugin on VimEnter which will undoubtedly break shit at an
  # unopportune moment
  # TODO somehow add the rest of ./nvim (e.g., ftplugin &co)
  #programs.neovim = {
  #  #package = pkgs.myNeovim; # how to override with vim-plug??
  #  enable = true;
  #  #extraConfig = (builtins.readFile ../config/nvim/init.vim);
  #};

  # simplest method; just places ./nvim/ in ~/.config/
  # for some reason this breaks initial invocation of `home-manager switch`.
  # It seemed to work after neovim was installed already, however.
  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };

  imports = [
    ./fish.nix
    ./gnome-kbd-shortcuts.nix
    ./dicod.nix
    #./i3.nix
  ];

  home.file = {

    ".tmux.conf".source = ../config/tmux/tmux.conf;
    ".ssh/config".source = ../config/ssh/sshconfig;
    ".config/gtk-3.0/gtk.css".source = ../config/gtk/gtk.css;
    # ".config/alacritty/alacritty.yml".source = "../alacritty.yml"

    ".gitconfig".source = ../config/git/gitconfig_global;
    ".dico".source = ../config/dico/.dico;

  };

  programs.bat = {
    enable = true;
    config = { theme = "TwoDark"; };
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      modify_font underline_thickness 150%
      modify_font underline_position 2
      font_family Source Code Pro
    '';
    settings = {
      cursor_shape = "beam";
    };
    keybindings = { };

  };

}
