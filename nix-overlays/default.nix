let
  overlays = {
    dico = (import ./dico);
    love_0_7 = import ./love_0_7;
    nottetris2 = import ./nottetris;
    #moby-thesaurus = import ./moby-thesaurus;
    dicts = import ./dicts; 
  };
  # TODO automate this
  # see https://nixos.wiki/wiki/Overlays
in with overlays; [ dicts dico love_0_7 nottetris2 ]
