return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		opts = {
			servers = {
				nixd = {
					command = { "nixd" },
					args = { "--inlay-hints=true", "-log=verbose" },
					settings = {
						nixd = {
							nixpkgs = {
								--expr = " import <nixpkgs> {}",
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
								suppress = { "sema-escaping-with" },
							},
						},
					},
				},
			},
		},
	},
}
