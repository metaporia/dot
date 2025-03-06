return {

	-- Non-lspconfig haskell plugin, handles lsp,
	-- see ~/.config/nvim/after/ftplugin/hasknll.lua for keymaps
	-- TODO: move to lazy plugin

	{
		"mrcjkb/haskell-tools.nvim",
		version = "^4", -- Recommended
		dependencies = { "nvim-telescope/telescope.nvim" },
	   lazy = false,
		-- ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
		-- for searching signature under cursor with hoogle, package-local file
		-- search, &c.
		config = function()
			require("telescope").load_extension("ht")
		end,
	},

	{
		"mrcjkb/haskell-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip" },
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
		config = function()
			local haskell_snippets = require("haskell-snippets").all
			require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
		end,
	},
}
