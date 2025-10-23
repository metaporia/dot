{
  services.syncthing = {
    enable = true;
    # TODO: 
    # - declaritively configure folders here, rather than via GUI, set up
    # - encrypt private logs (see org-crypt perhaps?); for now exclude
    #   ./finance.org and ./.git

    # NOTE: wrt conflict between git and syncthing:
    # - hide all git files from syncthing
    # - so long as the ~/org dir on other devices don't use git, then
    #   everything works fine (push/pull) from my laptop, edits made anywhere
    #   sync to working tree--let's see if it gets fucked or not.

    # - ios device id: "45QEM54-UW3HGEB-NSC7G5C-POHHQGC-S7RLJLB-WGYYRRY-LQ6FRTL-CLB45AB"
    # - 

  };
}
