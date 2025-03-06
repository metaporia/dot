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

local function execute_line()
  -- local line = vim.api.nvim_get_current_line()
  -- local out = vim.api.nvim_exec_lua(line)
  vim.cmd[[.,.lua]]
end

vim.keymap.set(
	"n",
	"<leader><leader>s",
	execute_buffer,
	{ noremap = true, silent = true, desc = "Save & source current buffer" }
)

vim.keymap.set(
	"n",
	"<leader><leader>l",
	execute_line,
	{ noremap = true, silent = false, desc = "Execute line" }
)

vim.keymap.set("c", "<c-v>", function()
	local cmd = vim.fn.getcmdline()
	vim.api.nvim_input("<Esc>")
	print(cmd)
	vim.schedule(function()
		local output = vim.api.nvim_exec2(cmd, { output = true }).output
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { output })
		vim.print(output)
		vim.api.nvim_open_win(buf, true, { vertical = true })
	end)
end, {
	noremap = true,
	silent = true,
	desc = "Run ex command, open result in scratch buffer",
})

vim.keymap.set(
	"n",
	"<leader>vr",
	function()
		local buf = vim.api.nvim_create_buf(false, true)
		local paths = vim.api.nvim_list_runtime_paths()
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, paths)
		vim.api.nvim_open_win(buf, true, { vertical = true })
	end,
	{ noremap = true, silent = true, desc = "Pretty print rtp to scratch buf" }
)

-- nice lua functions

-- check if string is in array
-- from https://stackoverflow.com/questions/33510736/check-if-array-contains-specific-value
function M.has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

return M
