-- add nix-managed lua-modules to 'package.path'
-- Add nix managed plugin dirs (for non-lazy). Currently only contains
-- 'generated-package-path.lua'
--
-- - Add lua module path: ~/.local/share/nvim/nix
--
-- - These modules/plugins/packages, what have you, will not be autoloaded, and
--   must be `required`.
-- 
-- - Example: load simple lua module
-- ```lua
-- local example = require('nix.example')
-- example.hello()
-- ```

local nix_pack_path = vim.fn.stdpath("data") .. "/nix"
vim.opt.rtp:prepend(nix_pack_path)

-- we need lua rock magick and lazy couldn't jive with nix so I just patched it in
require("generated-package-path")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- require('dico.nvim').setup()

-- apparrently, mapleader must be set before lazy is loaded
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.o.termguicolors = true

-- 'plugins' is a directory of (lazy) plugin specifications
-- 'opts' is lazy.nvim configuration
require("lazy").setup({
	{ import = "aporia.plugins" },
	{ import = "aporia.plugins.ui" },
	{ import = "aporia.plugins.editor" },
	{ import = "aporia.plugins.lsp" },
	{ import = "aporia.plugins.code" },
	{ import = "aporia.plugins.langs" },
	{ import = "aporia.plugins.neorg" },
	--{ import = "aporia.plugins.include"},
	--{ import = "aporia.plugins.quarantine"}
})

require("aporia.config.keymaps")
require("aporia.config.options")
require("aporia.config.misc")

vim.cmd([[colorscheme tokyonight-moon]])

-- FIXME: broken macro key, 'q'
-- it's one of these:
-- ○ noice.nvim
-- ○ nui.nvim
-- ○ nvim-notify
-- ○ tmux.nvim
-- ○ which-key.nvim
