-- keymaps

local k = vim.keymap

local function noremap(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

noremap("n", "\\", ",")

noremap("i", "jk", "<Esc>")
noremap("n", "<leader>w", ":w<CR>")

noremap("n", "<Leader>r", require("aporia.reload").reload_config)
-- TODO make interactive function that:
-- 1. displays editable confirmation msg for last command
-- 2. runs redir@r
-- 3. runs command
-- 4. ends capture
-- 5. puts results in dead buffer
noremap("n", "<leader>rr", 'q:kyypI redir @r | execute "<Esc>A" | redir end<Esc>2f|')

noremap("n", "<C-n>", ":bn<CR>") -- buffers
noremap("n", "<C-p>", ":bp<CR>")
noremap("n", "<C-k>", ":bd<CR>")

noremap("n", "<Leader>vh", ':let @/ = ""<CR>')
noremap("n", "<Leader>vl", ":se list!<CR>")
noremap("n", "<Leader>vs", ":se spell!<CR>")
noremap("n", "<Leader>z", "1z=")

noremap("i", "<C-f>", "<Right>")
noremap("i", "<C-b>", "<Left>")
noremap("i", "<C-e>", "<Esc>A")
noremap("i", "<C-a>", "<Esc>I")
noremap("i", "<M-f>", "<Esc>ea")
noremap("i", "<M-b>", "<Esc>bi")

-- emacs movements insert mode
--

-- system clipboard
noremap("n", "<Leader>c", '"+y') -- yank to clip
noremap("v", "<Leader>c", '"+y')

noremap("n", "<Leader>s", '"*y') -- yank to sel
noremap("v", "<Leader>s", '"*y')

noremap("n", "<Leader>p", '"+p') -- past system clip
noremap("n", "<Leader>is", '"*p') -- past system sel


-- terminal maps
-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n>:bd!<CR>]], { noremap = true, silent = true })
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { noremap = true, silent = true })

-- FIXME: move to dico.nvim

function GoldenDict(word)
  local cmd = "silent !goldendict "  .. "" .. word .. " & disown"
  vim.cmd(cmd)
  --  switch focus to goldendict
  vim.cmd[[silent !hyprctl dispatch focuswindow class:GoldenDict-ng ]]
end
-- GoldenDict("modulate")

vim.keymap.set("n", "<leader>dg", function () GoldenDict(vim.fn.expand('<cword>')) end)


