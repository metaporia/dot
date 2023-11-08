{ pkgs }:

{
  home.username = "test";
  home.homeDirectory = "/home/test";
  home.packages = with pkgs; [
    firefox
    scripts
    exa
    ripgrep
    xclip
    tmux
    gnome.gnome-tweaks
    # cpp nixpkgs test
    clang_12
    lldb_12
    llvmPackages_12.libcxx
    clang-tools_12
  ];

  imports = [ 
    ./fish.nix
    ./gnome-kbd-shortcuts.nix
  ];
}


