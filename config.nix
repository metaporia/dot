{
  allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; {

      # Ideally (for now at least), home-manager installs vim-plug which I can call
      # manually from neovim to install plugins (I want to keep the config
      # compatible with my arch build as long as possible).
      myNeovim = neovim.override {
        configure = {
          packages.myCustomPackages = with pkgs.vimPlugins; {
            start = [ vim-plug ];
          };
        };
      };

    };
}
