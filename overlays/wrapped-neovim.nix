# Wraps neovim
final: prev:

let
  generated-package-path = final.writeTextFile rec {
    name = "generated-package-path.lua";
    text = ''
      package.path = package.path .. ";" .. "${final.luajitPackages.magick}/share/lua/5.1/?/init.lua"
      package.path = package.path .. ";" .. "${final.luajitPackages.magick}/share/lua/5.1/?.lua"
    '';
    destination = "/share/nvim/runtime/lua/${name}";

  };
in {

  wrapped-neovim = final.symlinkJoin {
    name = "wrapped-neovim";
    paths = [
      prev.neovim
      #generated-package-path 
    ];
  };

}
