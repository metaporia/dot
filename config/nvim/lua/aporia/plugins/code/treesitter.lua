return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufWritePre", "BufNewFile", "VeryLazy" },
		-- from LazyVim [treesitter.lua](https://github.com/LazyVim/LazyVim/blob/12818a6cb499456f4903c5d8e68af43753ebc869/lua/lazyvim/plugins/treesitter.lua)
		lazy = vim.fn.argc(-1) == 0,
		init = function(plugin)
			-- PERF; add nvim-treesitter queries to the rtp and it's custom query
			-- predicates early This is needed because a bunch of plugins no longer
			-- `require("nvim-treesitter")`, which no longer trigger the
			-- **nvim-treesitter** module to be loaded in time. Luckily, the only
			-- things that those plugins need are the custom queries, which we make
			-- available during startup.
			--
			-- TLDR: most plugins which depend on treesitter don't have to require it
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")

			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		end,

		opts_extend = { "ensure_installed" },
		-- normal mode 'zi' to enable folding
		--vim.opt.foldmethod = "expr"
		opts = {
			--vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			--vim.opt.foldlevelstart = 2
			--vim.opt.foldenable = false
			auto_install = true,
			sync_install = true,
			ignore_install = {},
			modules = {},
			-- TODO:
			--  * lua indent
			--  * cpp clangd, clang-format, indentation
			ensure_installed = {
				"bash",
				"cpp",
				"haskell",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"query",
				"regex",
				"vim",
				"vimdoc",
			},
			--auto_install = true,
			--ignore_install = { "javascript" },
			highlight = {
				enable = true,
				--additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
				disable = { "markdown", "markdown_inline" },
			},
			incremental_selection = {
				enable = true,
			},
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- leave default config as is as we're using mini.ai with the .scm (query
	-- file, I think) generated by nvim-treesitter-textobjects
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		--enabled = true,
		config = false,
		--local util = require('aporia.util')

		-- from LazyVim treesitter.lua:
		--
		-- If treesitter is already loaded, we need to run config again for textobjects
		--if util.is_loaded("nvim-treesitter") then
		--  require("nvim-treesitter.configs").setup({
		--    textobjects = { move = { enable = true, set_jumps = true } },
		--  })
		--end
	},
}
