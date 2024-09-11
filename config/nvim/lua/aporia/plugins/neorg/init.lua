return {

	{
		"nvim-neorg/neorg",
    ft = { "norg"},
		--lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = { sputum = "~/sputum/neorg" },
						},
						default_workspace = "sputum",
					},
				},
			})
		end,
	},


	{
		"3rd/image.nvim",
    ft = {"markdown", "norg"},
		--dependencies = { "leafo/magick" },
		config = true,
	},

	-- {
	--   "leafo/magick"
	-- },
}
