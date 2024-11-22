return {

	{
		"OXY2DEV/markview.nvim",
		lazy = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "markdown", "markdown_inline", "html" } },
	},
}
