-- # Claude-generated
---@type vim.lsp.Config
return {
  cmd = { 'nixd', '--inlay-hints=true' },
  filetypes = { 'nix' },
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import (builtins.getFlake "/home/aporia/dot").inputs.nixpkgs {}',
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake "/home/aporia/dot").nixosConfigurations.kerfuffle.options',
        },
        home_manager = {
          expr = '(builtins.getFlake "/home/aporia/dot").homeConfigurations.aporia.options',
        },
      },
      diagnostic = {
        suppress = { 'sema-escaping-with' },
      },
    },
  },
}
