return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},

		cmd = { "Telescope" },

		opts = function()
			return {
				pickers = {
					buffers = {
						mappings = {
							-- TODO:
						},
					},
				},
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						-- TODO: make this dynamic based on width:height ratio
						flex = {
							flip_columns = 180,
						},
						preview_cutoff = 20,
						--vertical = { },
						--horizontal = { },
					},
				},
			}
		end,
		keys = {

			{ "<leader>lf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>lg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			--{'<leader>lg', builtin.live_grep, {}) },
			{
				"<leader>lb",
				function()
					require("telescope.builtin").live_grep({ grep_open_files = true })
				end,
				desc = "Live grep open files",
			},
			{
				"<leader>b",
				function()
					local builtin = require("telescope.builtin")
					local action_state = require("telescope.actions.state")
					builtin.buffers({
						--initial_mode = "normal",
						attach_mappings = function(prompt_bufnr, map)
							local delete_buf = function()
								local current_picker =
									action_state.get_current_picker(prompt_bufnr)
								current_picker:delete_selection(function(selection)
									vim.api.nvim_buf_delete(selection.bufnr, { force = true })
								end)
							end

							map("n", "<c-k>", delete_buf)
							map("i", "<c-k>", delete_buf)

							return true
						end,
					}, {
						sort_lastused = true,
						sort_mru = true,
						theme = "dropdown",
					})
				end,
				desc = "Buffers",
			},
			{ "<leader>lh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>lr", "<cmd>Telescope resume<cr>", desc = "Telescope Resume" },
			{
				"<space>s",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				desc = "Telescope Workspace Symbols (LSP)",
			},
		},
	},

}
