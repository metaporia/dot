
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

// TODO Enable handling of databases in dict.org format:
load-module  dict_wordnet {
  command "dictorg sort trim-ws dbdir=${dictdDBs.wordnet}/share/dictd";
}

database {
    name "wordnet";
    handler "dict_wordnet database=wn";
}

max-children 10;
inactivity-timeout 5;

''
