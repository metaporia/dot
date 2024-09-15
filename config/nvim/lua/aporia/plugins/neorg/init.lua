return {

	{
		-- wiki https://github.com/nvim-neorg/neorg/wiki
		"nvim-neorg/neorg",
		ft = { "norg" },
		--keys = { "<leader>f", "<Esc>gg=G<C-O>", ft = "norg", desc = "Format file" },
		dependencies = {
			"3rd/image.nvim",
			--cond = function() return false end,
			ft = { "norg" },
		},
		--ft = { "norg" },
		--keys = {
		--	{
		--		"<leader>nj",
		--		function()
		--			local dirman = require("neorg").modules.get_module("core.dirman")
		--			dirman.create_file(vim.fn.strftime("%y.%m.%d"), "sputum", {
		--				no_open = false, -- open file after creation?
		--				force = false, -- overwrite file if exists
		--				metadata = {}, -- key-value table for metadata fields
		--			})
		--		end,
		--		desc = "Open new journal entry (Neorg)",
		--	},
		--},
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		keys = {
			{
				"<leader>nt",
				"<cmd>Neorg tangle current-file<CR>",
				ft = "norg",
				desc = "Tangle current file (Neorg)",
			},
			{
				"<leader>nm",
				"<Plug>(neorg.looking-glass.magnify-code-block)",
				desc = "Magnify code block (Neorg)",
				ft = "norg",
			},

			{
				"<leader>nmu",
				"<Plug>(neorg.text-objects.item-up)",
				ft = "norg",
				desc = "Move item up (Neorg)",
			},
			{
				"<leader>nmd",
				"<Plug>(neorg.text-objects.item-down)",
				ft = "norg",
				desc = "Move item down (Neorg)",
			},
			-- * Text objects
			-- headings
			{
				"iH",
				"<Plug>(neorg.text-objects.textobject.heading.inner)",
				mode = { "o", "x" },
				ft = "norg",
				desc = "Select heading inner (Neorg)",
			},
			{
				"aH",
				"<Plug>(neorg.text-objects.textobject.heading.outer)",
				mode = { "o", "x" },
				ft = "norg",
				desc = "Select heading outer (Neorg)",
			},
			-- tags
			{
				"iT",
				"<Plug>(neorg.text-objects.textobject.tag.inner)",
				mode = { "o", "x" },
				ft = "norg",
				desc = "Select tag inner (Neorg)",
			},
			{
				"aT",
				"<Plug>(neorg.text-objects.textobject.tag.outer)",
				mode = { "o", "x" },
				ft = "norg",
				desc = "Select tag outer (Neorg)",
			},
			-- lists
			{
				"il",
				"<Plug>(neorg.text-objects.textobject.list.inner)",
				mode = { "o", "x" },
				ft = "norg",
				desc = "Select list inner (Neorg)",
			},
			{
				"al",
				"<Plug>(neorg.text-objects.textobject.list.outer)",
				mode = { "o", "x" },
				ft = "norg",
				desc = "Select list outer (Neorg)",
			},
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.autocommands"] = {},
					["core.latex.renderer"] = {
						config = {
							conceal = true,
							render_on_enter = true,
						},
					},
					["core.integrations.image"] = {},
					["core.integrations.nvim-cmp"] = {},
					["core.integrations.treesitter"] = {},
					["core.text-objects"] = {},
					["core.neorgcmd"] = {},
					["core.dirman"] = {
						config = {
							workspaces = { sputum = "~/sputum/neorg" },
						},
						default_workspace = "sputum",
					},
					["core.tangle"] = {
						config = { tangle_on_write = false },
					},
					["core.export"] = {},
				},
			})
		end,
	},

	{
		"3rd/image.nvim",
		ft = { "markdown", "norg" },
		--dependencies = { "leafo/magick" },
		opts = {
			neorg = {
				enabled = true,
			},
		},
	},
}
