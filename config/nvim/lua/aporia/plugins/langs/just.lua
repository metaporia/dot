return {
	--{
	--	"NoahTheDuke/vim-just",
	--	ft = { "just" },
	--},
	--

{
		"nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy"},
    opts = { ensure_installed = { 'just'}}
		-- opts = function(_, opts)
		-- 	opts.ensure_installed = opts.ensure_installed or {}
		-- 	vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
		-- end,
	}
}
