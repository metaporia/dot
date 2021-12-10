let overlays = {
  dico = (import ./dico);
  nottetris2 = import ./nottetris;
};
in with overlays; [ dico nottetris2 ]
