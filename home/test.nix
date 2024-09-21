{ pkgs, ... }:

{
  home.username = "test";
  home.homeDirectory = "/home/test";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    firefox
    eza
    ripgrep
    #xclip
    tmux
    gnome-tweaks
    # cpp nixpkgs test
    #clang_12
    #lldb_12
    #llvmPackages_12.libcxx
    #clang-tools_12
  ];

  imports = [ 
    ./fish.nix
    ./gnome-kbd-shortcuts.nix
  ];

  home.file = {
    ".tmux.conf".source = ../config/tmux/tmux.conf;
  };
}


