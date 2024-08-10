return {
	{
		"NeogitOrg/neogit",
    disable = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			--"ibhagwan/fzf-lua", -- optional
		},
		keys = {
			{
				"<leader>gg",
				function()
					require("neogit").open()
				end,
				{ mode = "n", desc = "Neogit open" },
			},
		},

		config = true,
	},
}
