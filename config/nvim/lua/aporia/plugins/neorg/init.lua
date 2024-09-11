return {

	{
		"nvim-neorg/neorg",
		ft = { "norg" },
		keys = {
			{
				"<leader>nj",
				function()
					local dirman = require("neorg").modules.get_module("core.dirman")
					dirman.create_file(vim.fn.strftime("%y.%m.%d"), "sputum", {
						no_open = false, -- open file after creation?
						force = false, -- overwrite file if exists
						metadata = {}, -- key-value table for metadata fields
					})
				end,
				desc = "Open new journal entry (Neorg)",
			},
		},
		--lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.integrations.image"] = {},
					["core.integrations.nvim-cmp"] = {},
					["core.latex.renderer"] = {},
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
		ft = { "markdown", "norg" },
		--dependencies = { "leafo/magick" },
		config = true,
	},
}
