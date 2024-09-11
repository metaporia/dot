# Wraps neovim
final: prev:
{

  neovim = prev.neovim.overrideAttrs (old:  {
    buildInputs = [ prev.lua5_1 ];
  });

}
