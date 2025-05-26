return {
	{
		"NeogitOrg/neogit",
		-- disable = true,
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

		opts = {
			graph_style = "kitty",
			disable_line_numbers = false,
			disable_relative_line_numbers = false,
			integrations = {
				-- use telescope for picker in place of nvim.ui.select
				-- telescope = true,
				snacks = true,
			},
			mappings = {
				rebase_editor = {
          -- move drop from "d" -> "D" so "dd" deletes lines as usual
					["D"] = "Drop",
          ["d"] = false
				},
			},
		},
	},
}
