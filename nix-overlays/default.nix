let
  overlays = {
    dico = (import ./dico);
    love_0_7 = import ./love_0_7;
    nottetris2 = import ./nottetris;
  };
in with overlays; [ dico love_0_7 nottetris2 ]
