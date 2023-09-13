
{pkgs, dico, dictdDBs, ... }:
''
/* A sample configuration for GNU dicod */

capability (mime,xversion);
timing yes;
// TODO paramaterize $HOME
access-log-file "/home/aporia/.dictd-access_log";
access-log-format "%h %l %u %t \"%r\" %>s %b \"\" \"%C\"";

// ADDED
module-load-path ("${dico}/lib/dico");
load-module gcide;
database {
  name "gcide";
  handler "gcide dbdir=${dico}/gcide-${dico.gcideVersion}";
}

// instantiate dict handler
load-module dict {
    command "dictorg sort trim-ws dbdir=/run/current-system/etc/profiles/per-user/aporia/share/dictd/";   
}

database {
    name "wordnet";
    handler "dict database=wn";
}

database {
    name "wiktionary";
    handler "dict database=wiktionary-en";
}

max-children 10;
inactivity-timeout 5;

''
