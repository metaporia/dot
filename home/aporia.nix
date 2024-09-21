{ pkgs, config, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aporia";
  home.homeDirectory = "/home/aporia";

  home.packages = with pkgs; [
    # editors
    emacs
    # DICO

    # pandoc/latex
    pandoc
    # neorg latex requires dvipng 

    texliveFull
    #texlivePackages.standalone
    #texlivePackages.amsmath
    #texlivePackages.amssyb
    #texlivePackages.graphicx

    dico
    #dictdDBs.wordnet
    #dictdDBs.wiktionary
    killall
    just
    docker
    scripts
    getoptions
    firefox
    discord
    eza # TODO fix scripts to use eza
    fd
    ripgrep
    hyperfine
    vlc
    just
    #chrome-gnome-shell
    #gnomeExtensions.hide-top-bar
    nixos-option
    nix-update
    git-lfs
    gh
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
    # compiler toolchains
    # cs19
    #lldb_12
    #clang_12
    #llvmPackages_12.libcxx
    #clang-tools_12
    #sshfs
    #cling

    gdb
    cmake # for nvim telescope fzf native extension
    zoom-us
    #wrapped-neovim
    # nvim deps
    nixd
    stylua
    moreutils # tmux-resurrect script needs 'sponge'
    imagemagick
    imagemagick.dev

    tree-sitter # to generate parsers from grammar
    # neorg (from overlay)
    norg-fmt
    shfmt


    #lua51Packages.luarocks
    #lua51Packages.lua

    #lua51Packages.magick

    luajitPackages.luarocks
    luajitPackages.lua
    # this needs to be added to ~/.config/nvim/nix/package-path.lua
    luajitPackages.magick
    luajit

    # nvim: neorg: latex rendering

    #lua51Packages.lua


    # tmux
    tmux
    bc # for tokyo-night-tmux's netspeed and git widgets

  ];

  # nvim package.path
  # we should add a home-manager module for neovim packages,
  # and generate the package-path.lua for it
  # 
  # Adding the generated file to ~/.config/nvim keeps ~/dot dirty, so we'll put
  # 'em in the nvim package's runtime path
  xdg.enable = true;
  xdg.dataFile."nvim/nix/lua/generated-package-path.lua".text = ''
    package.path = package.path .. ";" .. "${pkgs.luajitPackages.magick}/share/lua/5.1/?/init.lua"
    package.path = package.path .. ";" .. "${pkgs.luajitPackages.magick}/share/lua/5.1/?.lua"
  '';

  # xdg.configFile."nvim/lua/nix/generated-package-path.lua".text = ''
  #   package.path = package.path .. ";" .. "${pkgs.luajitPackages.magick}/share/lua/5.1/?/init.lua"
  #   package.path = package.path .. ";" .. "${pkgs.luajitPackages.magick}/share/lua/5.1/?.lua"
  # '';



  # nixd flags
  home.sessionVariables.NIXD_FLAGS =
    "--inlay-hints=true -log=error --semantic-tokens=true";

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

  # (OLD) TODO so I noticed that my macbook's dict output had indentation sensitive
  # line-wrapping. Apparently dict-gcide's conversion of the *.CIDE files is
  # better than that of dico (who knew!); but in any case the data is a
  # shit-show, as we well know, and dict seems to handle it better. So, we
  # should switch from dico to dict (which may involve making a dict-gcide nix
  # package--see arch's dict-gcide), and then get back to work sanitizing that
  # damn dictionary (remember to update to 0.53--oh god the progress staled!).
  # 
  # NB: gcide 0.48 was converted (poorly in spots) to the DICT format.
  # [this](https://github.com/rickysarraf-notmine/gcide) seems to be the likely
  # converter program. It puts it all neatly formatted into a *.dict file, and
  # then dictd just queries it. no runtime shenanigans required to pretty print
  # definitions
  services.dicod = {
    enable = true;
    # TODO: enable dicod module support for dictDBS.*
    # TODO: gcide is enabled in dico overlay
    packages =
      let dictdDBs = pkgs.dictdDBs;
      in with pkgs.dicts; [
        # for now enable all from dict-dbs
        devils
        dictdDBs.wiktionary
        dictdDBs.wordnet
        easton
        elements
        foldoc
        hitchcock
        jargon
        moby-thesaurus
        vera
        world95
      ];
  };

  systemd.user.startServices = "sd-switch"; # requires dbus session

  # Now defined in ../modules/home/dicod.nix
  #systemd.user.services = {
  #  dicod = {
  #    Unit = { Description = "GNU Dico DICT server"; };
  #    Service = {
  #      # docker run --name="dicod" --rm -d -p2628 beryj7/dicod-docker:latest
  #      ExecStart = "${pkgs.dico}/bin/dicod -f --config=/home/aporia/.config/dicod.conf";
  #    };
  #    Install = { WantedBy = [ "default.target" ]; };
  #  };
  #};

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

  # Based on: https://github.com/nix-community/home-manager/issues/589
  # Not sure of the internals but hm manages the link and links it to the actual
  # config dir allowing for nvim config mutability without a system rebuild
  # FIXME currently requires manual symlink
  #xdg.configFile."nvim" = {
  #  source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ../config/nvim);
  #  recursive = true;
  #};

  # requires nixos-rebuild with `--impure` flag
  #xdg.configFile."hypr/hyprland.conf" = {
  #  source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath 
  #    ../config/hyprland.conf);
  #

  imports = [
    ./fish.nix
    #./gnome-kbd-shortcuts.nix
    ./dicod.nix
    ../modules/home/dicod.nix
    #./i3.nix
    #./wm/hyprland.nix
    ./tmux.nix
    ./kitty.nix
  ];

  home.file = {

    ".ssh/config".source = ../config/ssh/sshconfig;
    ".config/gtk-3.0/gtk.css".source = ../config/gtk/gtk.css;
    # ".config/alacritty/alacritty.yml".source = "../alacritty.yml"

    ".gitconfig".source = ../config/git/gitconfig_global;
    ".dico".source = ../config/dico/.dico;

  };

  #programs.nix-index = {
  #  enable = true;
  #  symlinkToCacheHome = false;
  #};
  #programs.nix-index-database.comma.enable = true;


  programs.bat = {
    enable = true;
    config = { theme = "TwoDark"; };
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        hide_env_diff = true;
      };
    };
    fish.enable = true;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Set default applications: firefox, kitty/tmux, nvim
  xdg =
    {
      desktopEntries = {
        nvim = {
          name = "nvim";
          genericName = "Text Editor";
          exec = "kitty -- nvim %F";
          type = "Application";
          categories = [ "Utility" "TextEditor" ];
          startupNotify = false;
          terminal = false;
          mimeType =
            [
              "text/english"
              "text/plain"
              "text/x-makefile"
              "text/x-c++hdr"
              "text/x-c++src"
              "text/x-chdr"
              "text/x-csrc"
              "text/x-java"
              "text/x-moc"
              "text/x-pascal"
              "text/x-tcl"
              "text/x-tex"
              "application/x-shellscript"
              "text/x-c"
              "text/x-c++"
            ];

          settings = {
            Keywords = "Text;editor";
            #TryExec = "nvim";
          };


        };
      };
      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/plain" = [ "nvim.desktop" ]; # "kitty.desktop" ];
          "video/mp4" = [ "vlc.desktop" ];
        };
      };
    };

}
