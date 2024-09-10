# Wraps neovim
final: prev:
{

  neovim = prev.neovim.overrideAttrs (oldAttrs:  {
    buildInputs = oldAttrs.buildInputs ++ [ prev.lua5_1 ];
  });

}
