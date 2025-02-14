return {
	{
		"stevearc/resession.nvim",
		dependencies = {},
		--cond = function() return false end,
		lazy = false,

		opts = {
			-- exclude directories from session creation

			-- custom (my) options, must use full path (no "~") and omit trailing
			-- slash; otherwise, it won't trigger
			allowed_dirs = { "/home/aporia/dot", "/home/aporia/dot/config/nvim" },
			exclude_dirs = { "/home/aporia" },

			autosave = {
				enabled = true,
				interval = 60,
				notify = false,
			},
		},
		config = function(_, opts)
			local util = require("aporia.util")
			local resession = require("resession")
			resession.setup(opts)
			-- create session from current directory on exit
			vim.api.nvim_create_autocmd("VimLeavePre", {
				desc = "Resession: save dirsession",
				callback = function()
					print("resession saving")
					local cwd = vim.fn.getcwd()
					resession.save(cwd, { dir = "dirsession", notify = true })
				end,
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "Resession: create directory sessions",

				callback = function()
					-- Only load the session if nvim was started with no args
					if vim.fn.argc(-1) == 0 then
						-- apply opts.exclude_dirs and opts.allowed_dirs
						local cwd = vim.fn.getcwd()
						if
							util.has_value(opts.allowed_dirs, cwd)
							and not util.has_value(opts.exclude_dirs, cwd)
						then
							print("resession loading")
							-- Save these to a different directory, so our manual sessions don't get polluted
							resession.load(
								vim.fn.getcwd(),
								{ dir = "dirsession", silence_errors = false }
							)
						end
					end
				end,
				nested = true,
			})

			vim.keymap.set(
				"n",
				"<leader>ss",
				resession.save,
				{ desc = "Resession save", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>sl",
				resession.load,
				{ desc = "Resession load", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>sd",
				resession.delete,
				{ desc = "Resession delete", silent = true }
			)

			-- load dirsession
			vim.keymap.set("n", "<leader>sr", function()
				resession.load(
					vim.fn.getcwd(),
					{ dir = "dirsession", silence_errors = true }
				)
			end, { desc = "Resession load dirsession", silent = true })

			--vim.api.nvim_create_user_command('')
		end,
	},

	{
		-- NOTE: this kind of plugin spec extension/override must come /after/ the
		-- plugin it is extending
		"nvim-telescope/telescope.nvim",
		dependencies = { "scottmckendry/telescope-resession.nvim" },
		--cond = function() return false end,
		keys = {
			{
				"<leader>ll",
				function()
					require("telescope").extensions.resession.resession()
				end,
				desc = "Telescope resession",
			},
		},
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts or {}, {
				extensions = {

					resession = {
						path_substitutions = { { find = "/home/aporia", replace = "~" } },
						prompt_title = "Sessions",
						dir = "session",
					},
				},
			})
		end,
	},
}
