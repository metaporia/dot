-- misc

--augroup RestoreCursorShapeOnExit
--    autocmd!
--    autocmd VimLeave * set guicursor=a:hor20
--augroup END
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	pattern = { "*" },
	command = "set guicursor=a:ver25",
})
