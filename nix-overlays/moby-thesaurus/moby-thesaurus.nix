{ lib, stdenv, fetchgit, zip, ...}:

let
  pname = "moby-thesaurus";
  version = "1.0";

in

stdenv.mkDerivation {
  inherit pname version;

  # aporia override source
  src = fetchgit {
      owner = "ferdnyc";
      repo = "dictd-dicts";
      rev = "83cdc82a5f269faee814fdd30ebbb278a19cc91b";
      sha256 = "0rjlmvcm4c69yln0panj4p0mms5w6b0w5c5bnjrpmylkbgqncipy";
    };


  installPhase =
  ''
  echo "hello";
  '';

  meta = with lib; {
    description = "Packages many popular dictionaries for use with dicod/dict dictionary servers";
    platforms = platforms.linux;
    license = licenses.wtfpl;
    #maintainers = with maintainers; [ yorickvp ];
  };

}
