local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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


-- apparrently, mapleader must be set before lazy is loaded
vim.g.mapleader = ","
vim.g.maplocalleader = ","


-- 'plugins' is a directory of (lazy) plugin specifications
-- 'opts' is lazy.nvim configuration
require("lazy").setup("keane.plugins")

require("keane.config.keymaps")
require("keane.config.options")
