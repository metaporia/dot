# From dictd counterpart, dictd-db-collector. 
# See https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/servers/dict/dictd-db-collector.nix

{ stdenv, lib, dict, dico, libfaketime }:
({ enableGcide, accessLogDir, dictlist, dbDir, allowList ? [ "127.0.0.1" ], denyList ? [ ] }:

# TODO: 
# - get find dictd module in nixos/modules and find out how the package list is
# converted into `dictlist`
# See https://github.com/NixOS/nixpkgs/blob/nixos-23.05/nixos/modules/services/misc/dictd.nix
# - (in dicod module) make /etc/dicod.conf or /home/$USER/.dicod.conf (parameterize)


/*
  dictlist is a list of form
  [ { filename = /path/to/files/basename;
  name = "name"; } ]
  basename.dict.dz and basename.index should be
  dict files. Or look below for other options.
  allowList is a list of IP/domain *-wildcarded strings
  denyList is the same..
*/

# TODO add dictorg module to config, add gcide option to dicod module
let
  link_arguments = map
    (x: '' "${x.filename}" '')
    dictlist;
  databases = lib.concatStrings (map
    (x:
      "${x.name}  ${x.filename}\n")
    dictlist);
  allow = lib.concatStrings (map (x: "allow ${x}\n") allowList);
  deny = lib.concatStrings (map (x: "deny ${x}\n") denyList);
  # TODO merge module path if more dico modules, e.g., python, are needed
  # needs dico overlay in nixpkgs to build
  dictHandler = ''
    load-module dict {
        command "dictorg sort trim-ws dbdir=${dbDir}";   
    }
  '';
  gcideModule =
    if enableGcide then ''
      module-load-path ("${dico}/lib/dico");
      load-module gcide;
      database {
        name "gcide";
        handler "gcide dbdir=${dico}/gcide-${dico.gcideVersion}";
      }
    '' else "";
  configPreamble = ''
    capability (mime,xversion);
    timing yes;
    access-log-file "${accessLogDir}/.dicod-access_log";
    # TODO add option for this
    # access-log-format \"%h %l %u %t \"%r\" %>s %b \"\" \"%C\"\";
  '';


  #accessSection = ''
  #  access {
  #    ${allow}
  #    ${deny}
  #  }
  #'';
  installPhase = ''
    mkdir -p $out/share/dicod
    mkdir -p $out/share/dictd
    cd $out/share/dicod
    echo '${configPreamble}' >> dicod.conf
    echo '${gcideModule}' >> dicod.conf
    echo '${dictHandler}' >> dicod.conf
    echo "${databases}" >databases.names
    for j in ${toString link_arguments}; do
      name="$(egrep '  '"$j"\$ databases.names)"
      name=''${name%  $j}
      if test -d "$j"; then
        if test -d "$j"/share/dictd ; then
          echo "Got store path $j"
          j="$j"/share/dictd
        fi
        echo "Directory reference: $j"
        i=$(ls "$j""/"*.index)
        i="''${i%.index}";
      else
        i="$j";
      fi
      echo "Basename is $i"
      base="$(basename "$i")"

      if [ -f "$(dirname "i$")"/locale ]; then
        locale=$(cat "$(dirname "$i")"/locale)
        echo "Locale is $locale"
        export LC_ALL=$locale
        export LANG=$locale
      fi 

      # Not necessary because we're using symlinkJoin to aggregate dicts

      #if test -e "$i".dict.dz; then
      #  ln -s "$i".dict.dz
      #else
      #  cp "$i".dict .
      #  source_date=$(date --utc --date=@$SOURCE_DATE_EPOCH "+%F %T")
      #  faketime -f "$source_date" dictzip "$base".dict
      #fi
      #ln -s "$i".index .

      #if [ -z $locale ]; then
      #  dictfmt_index2word --locale $locale < "$base".index > "$base".word || true
      #  dictfmt_index2suffix --locale $locale < "$base".index > "$base".suffix || true
      #fi

      echo "database {" >> dicod.conf
      echo "  name \"$base\";" >> dicod.conf;
      echo "  handler \"dict database=$base\";" >> dicod.conf;
      echo "}" >> dicod.conf
    done
  '';

in

stdenv.mkDerivation {
  name = "dicts-collector";

  nativeBuildInputs = [ libfaketime ];
  buildInputs = [ dict ];

  dontUnpack = true;
  inherit installPhase;
})
