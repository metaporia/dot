-- Claude-assisted
-- TODO:
-- * incremental_selection: was enabled with <C-n> grow. The new nvim-treesitter
--   main may not ship this module — check after migration and add a keybind or
--   alternative (e.g. vim-expand-region or native visual mode tricks)
-- * indent: was enabled, disabled for markdown/markdown_inline. New API uses
--   vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" per filetype
--   (experimental). Not wired up yet — revisit when lua/cpp indent is fixed.
--   (see original TODO: lua indent, cpp clangd/clang-format/indentation)
-- * The LazyVim PERF trick (add_to_rtp + require query_predicates early) is
--   gone — no longer needed with new API. If plugins break due to missing
--   queries at startup, revisit.
-- * latex parser: commented out below, preserved for future use.

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- { parser, { ft, ... } }
			-- absent ft list → use parser name as filetype
			-- empty ft list  → injection-only, skip in FileType pattern
			local parsers = {
				{ "python" },
				{ "bash",            { "bash", "sh" } },
				{ "cpp",             { "c", "cpp", "objcpp" } },
				{ "haskell" },
				{ "json" },
				{ "lua" },
				{ "markdown" },
				{ "markdown_inline", {} },  -- skip, injection only
				{ "nix" },
				{ "query" },
				{ "regex",           {} },  -- skip, injection only
				{ "vim" },
				{ "vimdoc",          { "help" } },
				{ "ron" },
				{ "rust" },
				{ "toml" },
				{ "just" },
				{ "html" },
			}

			local parser_names, fts = {}, {}
			for _, p in ipairs(parsers) do
				table.insert(parser_names, p[1])
				local p_fts = p[2]
        -- if no ft table, use parser name,  
				if p_fts == nil then
					table.insert(fts, p[1])
				else -- NB: if `p_fts` is empty, this is a no-op
					vim.list_extend(fts, p_fts)
				end
			end

			require("nvim-treesitter").install(parser_names)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = fts,
				callback = function() vim.treesitter.start() end,
			})

			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

			-- custom latex parser (preserved for future use):
			--
			-- vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
			-- callback = function()
			--   require('nvim-treesitter.parsers').latex = {
			--     install_info = {
			--       path = '~/.local/site/parser',
			--       files = { 'latex.so' },
			--       generate = false,
			--     },
			--   }
			--   vim.treesitter.language.register('latex', { 'latex' })
			-- end})

			-- fold options (old config, kept for reference):
			-- vim.opt.foldlevelstart = 2
			-- vim.opt.foldenable = false
		end,
	},

	{
		-- kept for .scm query files used by mini.ai (gen_spec.treesitter captures)
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = false,
	},
}
