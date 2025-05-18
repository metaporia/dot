{ config, lib, pkgs, ... }: {

  # ok, so attempt #3 with devenv

  environment.systemPackages = with pkgs; [ devenv ];

}
# nasturtiumfilms wordpress setup

# current version: wordpress 6.7.1

# see https://nixos.wiki/wiki/Wordpress
# for configuration help

# scaffold and plugin derivation generation from:
# https://carlosvaz.com/posts/setting-up-a-wordpress-website-on-nixos/
#   let 
#   domain = "localhost";
#
#   # Auxiliary functions
#   fetchPackage = { name, version, hash, isTheme }:
#     pkgs.stdenv.mkDerivation rec {
#       inherit name version hash;
#       src = let type = if isTheme then "theme" else "plugin";
#       in pkgs.fetchzip {
#           inherit name version hash;
#           url = "https://downloads.wordpress.org/${type}/${name}.${version}.zip";
#         };
#       installPhase = "mkdir -p $out; cp -R * $out/";
#     };
#
#   fetchPlugin = { name, version, hash }:
#     (fetchPackage {
#       name = name;
#       version = version;
#       hash = hash;
#       isTheme = false;
#     });
#
#   fetchTheme = { name, version, hash }:
#     (fetchPackage {
#       name = name;
#       version = version;
#       hash = hash;
#       isTheme = true;
#     });
#
#   # Plugins
#
#   # google-site-kit = (fetchPlugin {
#   #   name = "google-site-kit";
#   #   version = "1.103.0";
#   #   hash = "sha256-8QZ4XTCKVdIVtbTV7Ka4HVMiUGkBYkxsw8ctWDV8gxs=";
#   # });
#
#   # # Themes
#   # astra = (fetchTheme {
#   #   name = "astra";
#   #   version = "4.1.5";
#   #   hash = "sha256-X3Jv2kn0FCCOPgrID0ZU8CuSjm/Ia/d+om/ShP5IBgA=";
#   # });
#
#   phlox = (fetchTheme {
#     name = "phlox";
#     version = "2.17.0";
#     hash = "sha256-CeZbWqzviN6EBXg1WXF70ajUlWxVV88HDRuchKxgsCg=";
#
#   });
#
#   wordpressUser = "wordpress";
#   wordpressGroup = "${wordpressUser}";
#
# in {
#
#   # create mutable wordpress dir:
#   # https://discourse.nixos.org/t/can-i-install-mutable-wordpress-in-nixos/37479/2
#
#   # 1. create user and group
#   users.users."${wordpressUser}" = {
#     isNormalUser = true;
#     group = "${wordpressGroup}";
#     packages = with pkgs; [
#       git
#       php
#       php.packages.composer
#     ]
#       };
#
#     users.groups."${wordpressGroup}" = {}; # create group
#
#     # 2. create folder to host wordpress code at:
#     # - /srv/wordpress with loose permissions
#
#     # 3.  php-fpm engine to run wp code
#     services.phpfpm.pools.wordpress = {
#       phpPackage = pkgs.php;
#       user = "${wordpressUser}";
#       group = "${wordpressGroup}";
#       settings = {
#         # FIXME: use nginx
#         "listen.owner" = config.services.caddy.user; # or nginx, httpd, etc...
#         "listen.group" = config.services.caddy.group;
#         "pm" = "dynamic"; # tweak the below options as needed, though the can be a decent start depending on your work load
#         "pm.max_children" = 16;
#         "pm.start_servers" = 4;
#         "pm.min_spare_servers" = 2;
#         "pm.max_spare_servers" = 4;
#         "pm.max_requests" = 2000;
#       };
#     };
#
#     services.nginx = {
#       enable = true;
#       # virtualHosts = "??";
#
#
#       # nginx config to serve dir from localhost:
#       # server {
#       #       listen       80;
#       #       server_name  localhost;
#       #
#       #       access_log  logs/localhost.access.log  main;
#       #
#       #       location / {
#       #           root /var/www/board/public;
#       #           index index.html index.htm index.php;
#       #       }
#       # }
#
#     }
#
#     # 4. set up db and grant `wordpressUser` necessary permissions
#     services.mysql.enable = true;
#     services.mysql.package = pkgs.mariadb;
#     services.mysql.ensureDatabases = [ "wordpress" ];
#     services.mysql.ensureUsers = [
#       { name = "${wordpressUser}";
#         ensurePermissions = {
#           # whatever wordpress requires you can put here
#         };
#       }
#     ];
#
#
#
#     # services = {
#     #   # nginx.virtualHosts.${domain} = {
#     #   #   enableACME = true;
#     #   #   forceSSL = true;
#     #   # };
#     #
#     #   wordpress = {
#     #     # webserver = "nginx";
#     #     sites."${domain}" = {
#     #       # plugins = { inherit google-site-kit; };
#     #       themes = { inherit phlox; };
#     #       settings = { 
#     #         WP_DEFAULT_THEME = "phlox"; 
#     #         WP_DEBUG = true;
#     #         WP_DEBUG_DISPLAY = true;
#     #       };
#     #     };
#     #
#     #     extraConfig = ''
#     #     @ini_set( 'display_errors', 1 );
#     #     '';
#     #   };
#     #
#     #   # services.wordpress.sites."localhost" = {
#     #   #   # name should be set to "wordpress" be default
#     #   #   # database.createLocally = true;
#     #   #   themes = { inherit (pkgs.wordpressPackages.themes)
#     #   #     phlox;
#     #   #   };
#     #   #   settings = {
#     #   #     WP_DEFAULT_THEME = "twentytwentytwo";
#     #   #     # WP_SITEURL = "https://example.org";
#     #   #     # WP_HOME = "https://example.org";
#     #   #     WP_DEBUG = true;
#     #   #     WP_DEBUG_DISPLAY = true;
#     #   #     # WPLANG = "de_DE";
#     #   #     # FORCE_SSL_ADMIN = true;
#     #   #     AUTOMATIC_UPDATER_DISABLED = true;
#     #   #   };
#     #   #   extraConfig = ''
#     #   #     @ini_set( 'display_errors', 1 );
#     #   #   '';
#     #   #
#     #   # };
#     #
#     #
#     # };
#
#     environment.systemPackages = with pkgs; [
#       wp-cli
#       wordpress
#     ];
#
#
#
#
#
#   }
#
