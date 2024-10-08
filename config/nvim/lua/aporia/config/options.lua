-- options

local opt = vim.o

opt.expandtab = true -- Use spaces instead of tabs
opt.ignorecase = true
opt.undofile = true
opt.backup = false

opt.tabstop = 2
opt.shiftwidth = 0
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true

opt.textwidth = 79
opt.breakindent = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.wildignorecase = true

opt.number = true
opt.relativenumber = true

opt.termguicolors = true

opt.listchars = "eol:¶,space:.,tab:|·,trail:·,extends:»,precedes:«"
-- jtcqln
--opt.formatoptions = 'tcroq

--opt.timeoutlen = 150
--opt.ttimeoutlen = 50

opt.cursorline = true

-- support formatting bulleted lists within comments
vim.cmd([[set formatoptions+=n]])

-- vim.opt.formatoptions:insert({'n'})
-- :set formatlistpat=^\\s*[\\-\\+\\*]\\+\\s\\+
opt.formatlistpat = "^\\s*[\\-\\+\\*]\\+\\s\\+"
