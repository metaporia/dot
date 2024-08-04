return {

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			{
				"rcarriga/nvim-notify",
				opts = {
					on_open = function(win)
						vim.api.nvim_win_set_config(win, { focusable = false })
					end,
				},
			},
		},
		keys = {
			--{ "<leader>sn", "", desc = "+noice" },
			{
				"<M-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<leader>snd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Dismiss All",
			},
			{
				"<leader>snt",
				function()
					require("noice").cmd("pick")
				end,
				desc = "Noice Picker (Telescope/FzfLua)",
			},
			-- {
			-- 	"<c-f>",
			-- 	function()
			-- 		if not require("noice.lsp").scroll(4) then
			-- 			return "<c-f>"
			-- 		end
			-- 	end,
			-- 	silent = true,
			-- 	expr = true,
			-- 	desc = "Scafterroll Forward",
			-- 	mode = { "i", "n", "s" },
			-- },
			-- {
			-- 	"<c-b>",
			-- 	function()
			-- 		if not require("noice.lsp").scroll(-4) then
			-- 			return "<c-b>"
			-- 		end
			-- 	end,
			-- 	silent = true,
			-- 	expr = true,
			-- 	desc = "Scroll Backward",
			-- 	mode = { "i", "n", "s" },
			-- },
		},
		-- configuration
		-- TODO: fix <c-f> and <c-b> to go forward/bock char in insert mode
		opts = {
			lsp = {
				hover = {
					silent = true, -- don't show message if hover unavailable
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documenttion"] = true,
				},
			},
			routes = {
				{
					filter = {
						-- Exclude messages here. `find = <pattern>` to match against
						-- message contents, and `event` will probably be "msg_show".
						any = {
							-- search string not found
							{ event = "msg_show", find = "E486" },
							{ event = "msg_show", find = "E553" },
							{ event = "msg_show", find = "E19" },
						},
					},
					opts = { skip = true },
				},
				{
					filter = {
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = false,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},
			views = {
				hover = { border = { style = "rounded" } },
				mini = {
					focusable = false,
				},
			},
		},
		config = function(_, opts)
			-- clear lazy.nvim messages
			--if vim.o.filetype == "lazy" then
			--	vim.cmd([[messages clear]])
			--end
			require("noice").setup(opts)
		end,
	},
}
