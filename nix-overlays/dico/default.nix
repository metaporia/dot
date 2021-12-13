self: super:

{
  dico = super.dico.overrideAttrs (oldAttrs: rec {

    ## ADDED
    # This looks like it will work but perhaps it should be done in my user
    # config as it really just amounts to placing configs and gcide in ${dico}/.
    # The only reason to write a custom dico package is if the configuration
    # needs tweaking, in which case an overlay should be used (I think).
    gcideVersion = "0.53";
    gcide = builtins.fetchurl {
      url = "ftp://ftp.gnu.org/gnu/gcide/gcide-${gcideVersion}.tar.gz";
      sha256 = "0y57w4gdnsk9p2rvlf91c6rgv46l2zm2nnpmir4ryis7haf1din2";
    };

    dicodConf = ''
        /* A sample configuration for GNU dicod */

        capability (mime,xversion);
        timing yes;
        access-log-file "/var/log/dictd-access_log";
        access-log-format "%h %l %u %t \"%r\" %>s %b \"\" \"%C\"";

        // ADDED
        module-load-path ("${placeholder "out"}/lib/dico");
        load-module gcide;
        database {
            name "gcide";
            handler "gcide dbdir=${placeholder "out"}/gcide-${gcideVersion}";
        }

        max-children 10;
        inactivity-timeout 5;
      '';

    # TODO allow toggling of flags
    configureFlags = [
      "--with-pcre"
    ];

    postInstall = ''
      mkdir -p $out/etc/
      mkdir -p $out/var/run
      echo keane
      echo "$dicodConf" > $out/etc/dicod.conf
      tar -xf $gcide -C $out/
      $out/libexec/idxgcide $out/gcide-${gcideVersion}
    '';

    # And then query with ./result/bin/dico --host 127.0.0.1 <query>

  });
}
