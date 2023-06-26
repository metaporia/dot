vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.o

opt.expandtab = true -- Use spaces instead of tabs

opt.ignorecase = true -- Ignore case

opt.undofile = true


local k = vim.keymap

k.set('i', 'jk', '<Esc>', { noremap = true })
k.set('n', '<Leader>w', ':w<CR>', { noremap = true })
