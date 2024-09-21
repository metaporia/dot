# doesn't touch the neovim package itself, but adds nix-managed lua
# modules/packages/plugins to `~/.local/share/nvim/nix/`
{ config, pkgs, lib, ... }:
with lib;
let cfg = config.programs.neovim-packages;
in {
  options.programs.neovim-packages = {
    # string is injected into description
    enable = mkEnableOption "neovim packages"; 
  };
  config = mkIf cfg.enable {
    # add packages to ~/.local/share/nvim/nix
  };
}
