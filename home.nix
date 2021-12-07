{ config, pkgs, ... }:

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
    fish
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
  home.stateVersion = "22.05";

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
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  # Alternatively, use neovim module:
  # super jank: the above links in the whole ./nvim/ dir, while the below
  # overwrites ./nvim/init.vim with itself (ik, ik--it's a dumpster fire)
  # As yet vim-plug installs itself from init.vim, the downside being that it
  # updates plugin on VimEnter which will undoubtedly break shit at an
  # unopportune moment
  programs.neovim = {
    #package = pkgs.myNeovim; # how to override with vim-plug??
    enable = true;
    extraConfig = (builtins.readFile ./nvim/init.vim);
  };



  home.file = {

    ".tmux.conf".source = ./.tmux.conf.desk;
    # ".config/alacritty/alacritty.yml".source = "./alacritty.yml"

    ".config/fish/config.fish".source = ./config.fish;
    ".config/fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
    ".config/fish/functions/fish_title.fish".source = ./fish_title.fish;

    ".gitconfig".source = ./gitconfig_global;

  };

  ########
  # TMUX #
  ########

  programs.bat = {
    enable = true;
    config = { theme = "TwoDark"; };
  };



}
