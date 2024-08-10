return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			local util = require("tokyonight.util")
			return {
				styles = { sidebars = "dark" },
				style = "night",
				on_highlights = function(highlights, colors)
					highlights.WinSeparator = {
						bold = true,
						fg = util.darken(colors.purple, 0.6),
					}
				end,
			}
		end,
	},
}
