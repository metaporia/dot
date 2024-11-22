return {
	--{
	--	"NoahTheDuke/vim-just",
	--	ft = { "just" },
	--},
	--

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "VeryLazy" },
		opts = { ensure_installed = { "just" } },
		-- opts = function(_, opts)
		-- 	opts.ensure_installed = opts.ensure_installed or {}
		-- 	vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
		-- end,
	},

	--- keys for this will go under <space> as it's a build tool and thus
	--- language related. The <space> prefix should mean "give mean lsp and
	--- language functionality".
	{
		"al1-ce/just.nvim",
		keys = {
			{ "<space>jd", "<cmd>JustDefault<CR>", desc = "just default" },
			{ "<space>js", "<cmd>JustSelect<CR>", desc = "just select" },
			{ "<space>jb", "<cmd>JustBuild<CR>", desc = "just build" },
			{ "<space>jr", "<cmd>JustRun<CR>", desc = "just run" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"rcarriga/nvim-notify",
			"j-hui/fidget.nvim",
		},
		config = true,
	},
}
