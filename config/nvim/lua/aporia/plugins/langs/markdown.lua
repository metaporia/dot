return {

	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
      "folke/tokyonight.nvim",
		},
		config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
      local presets = require('markview.presets').headings;
			local opts = {
				markdown = {
          headings = presets.glow,
					list_items = {
						shift_width = function(buffer, item)
							--- Reduces the `indent` by 1 level.
							---
							---         indent                      1
							--- ------------------------- = 1 ÷ --------- = new_indent
							--- indent * (1 / new_indent)       new_indent
							---
							local parent_indnet =
								math.max(1, item.indent - vim.bo[buffer].shiftwidth)

							return item.indent * (1 / (parent_indnet * 2))
						end,
						marker_minus = {
							add_padding = function(_, item)
								return item.indent > 1
							end,
						},
					},
				},

				-- preview = {
				-- 	icon_provider = "devicons",
				-- },
			}
      require('markview').setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"markdown",
				"markdown_inline",
				"html",
				-- "latex",
			},
		},
	},
}
