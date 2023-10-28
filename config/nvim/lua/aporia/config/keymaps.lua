-- keymaps 

local k = vim.keymap

local function noremap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

noremap('n', '\\', ',')

noremap('i', 'jk', '<Esc>')
noremap('n', '<Leader>w', ':w<CR>')

noremap('n', '<Leader>r', require('aporia.reload').reload_config)

noremap('n', '<C-n>', ':bn<CR>') -- buffers
noremap('n', '<C-p>', ':bp<CR>')
noremap('n', '<C-k>', ':bd<CR>')

noremap('n', '<Leader>vh', ':se hlsearch!<CR>')
noremap('n', '<Leader>vl', ':se list!<CR>')
noremap('n', '<Leader>vs', ':se spell!<CR>')
noremap('n', '<Leader>z', '1z=')

noremap('i', '<C-f>', '<Right>')
noremap('i', '<C-b>', '<Left>')
noremap('i', '<C-e>', '<Esc>A')
noremap('i', '<C-a>', '<Esc>I')
noremap('i', '<M-f>', '<Esc>ea')
noremap('i', '<M-b>', '<Esc>bi')


-- emacs movements insert mode
-- 

-- system clipboard
noremap('n', '<Leader>c', '"+y') -- yank to clip
noremap('v', '<Leader>c', '"+y')

noremap('n', '<Leader>s', '"*y') -- yank to sel
noremap('v', '<Leader>s', '"*y')

noremap('n', '<Leader>p', '"+p') -- past system clip
noremap('n', '<Leader>is', '"*p') -- past system sel


