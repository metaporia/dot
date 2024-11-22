return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",

		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return {
				options = {
					theme = "tokyonight",
					globalstatus = true,
				},

				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = {
						-- {
						-- 	require("noice").api.statusline.command.get,
						-- 	cond = require("noice").api.statusline.command.has,
						-- 	--color = { fg = "#ff9e64" },
						-- },

						-- {
						-- 	require("noice").api.statusline.mode.get,
						-- 	cond = require("noice").api.statusline.mode.has,
						-- 	color = { fg = "#ff9e64" },
						-- },
						"diagnostics",
					},
					lualine_y = { "filetype" },
					lualine_z = { "progress", "location" },
				},
				winbar = {
					lualine_a = {},
					lualine_b = { "filetype" },
					lualine_c = {
						{
							"filename",
							path = 4,
							--shorting_target = 50,
						},
					},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = { "filetype" },
					lualine_c = {
						{
							"filename",
							path = 4,
							--shorting_target = 50,
						},
					},
				},
			}
		end,
	},
}
