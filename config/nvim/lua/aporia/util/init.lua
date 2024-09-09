local M = {}
-- from [LazyVim.lsp.on_atttach](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/lsp.lua)

local lsp = {}
function lsp.on_attach(on_attach, name)
	return vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and (not name or client.name == name) then
				return on_attach(client, buffer)
			end
		end,
	})
end
M.lsp = lsp

function M.is_loaded(name)
	local Config = require("lazy.core.config")
	return Config.plugins[name] and Config.plugins[name]._.loaded
end

-- globals

P = vim.print

local function execute_buffer()
	vim.print("Sourcing current buffer")
	vim.cmd([[write | source %]])
end

vim.keymap.set(
	"n",
	"<leader><leader>s",
	execute_buffer,
	{ noremap = true, silent = true }
)

return M
