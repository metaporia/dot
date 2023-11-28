{ lib, stdenv, fetchFromGitHub, zip, ... }:

let
  # aporia override source
  src = fetchFromGitHub {
    owner = "ferdnyc";
    repo = "dictd-dicts";
    rev = "83cdc82a5f269faee814fdd30ebbb278a19cc91b";
    sha256 = "r0oKXF0VS54Udi0ZpV0Uu19Bv/6y0hAXF5DUdjE81Ag=";
  };

  # from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/servers/dict/dictd-db.nix
  makeDictdDB = _name:
    stdenv.mkDerivation {
      name = "dict-db-${_name}";
      inherit src;
      dbName = _name;
      dontBuild = true;
      #unpackPhase = '' tar xf  ${src} '';
      installPhase = ''
        mkdir -p $out/share/dictd
        cp ./${_name}.{index,dict.dz} $out/share/dictd
        echo en_US.UTF-8 > $out/share/dictd/locale
      '';
      # for diff locales
      # echo "${_locale}" >$out/share/dictd/locale

      meta = {
        description = "dictd-db dictionary for dictd/dicod";
        platforms = lib.platforms.linux;
      };
    };

in
{

  devils = makeDictdDB "devils";
  easton = makeDictdDB "easton";
  elements = makeDictdDB "elements";
  foldoc = makeDictdDB "foldoc";
  gazetteer = makeDictdDB "gazetteer";
  gcide = makeDictdDB "gcide";
  hitchcock = makeDictdDB "hitchcock";
  jargon = makeDictdDB "jargon";
  moby-thesaurus = makeDictdDB "moby-thesaurus";
  vera = makeDictdDB "vera";
  web1913 = makeDictdDB "web1913";
  # wn = makeDictdDB "wn";
  world95 = makeDictdDB "world95";
} 
