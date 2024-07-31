local M = {}

function M.reload_config()
	for name, _ in pairs(package.loaded) do
		if name:match("^aporia") and not name:match("nvim-tree") then
			package.loaded[name] = nil
		end
	end

	-- TODO I think this unnecessarily loads MYVIMRC twice (against the recommendation of
	-- lazy.nvim)
	vim.cmd({ cmd = "luafile", args = { vim.env.MYVIMRC } })
	vim.notify("Nvim config reloaded; N.B.: this excludes $MYVIMRC itself", vim.log.levels.INFO)
end

return M
