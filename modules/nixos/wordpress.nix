{pkgs, ... }: {
  # nasturtiumfilms wordpress setup

  # see https://nixos.wiki/wiki/Wordpress
  # for configuration help

  services.wordpress.sites."localhost" = {};
  environment.systemPackages = with pkgs; [
    wp-cli
  ];
}

