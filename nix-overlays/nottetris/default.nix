self: super:

{
  # Uses fork at gitlab.com/metaporia/not-tetris with dvorak-friendly bindings.
  nottetris2 = super.nottetris2.overrideAttrs (oldAttrs: rec {
    version = "2.0";
    pname = "nottetris2";
    src = super.fetchFromGitHub {
      owner = "metaporia";
      repo = "nottetris2";
      rev = "dee1e1451ae38c6b4b5680b7fd41d2a289861b83";
      sha256 = "0rjlmvcm4c69yln0panj4p0mms5w6b0w5c5bnjrpmylkbgqncipy";
    };
  });
}
