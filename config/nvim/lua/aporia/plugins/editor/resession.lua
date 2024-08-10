return {
	{
		"stevearc/resession.nvim",
		dependencies = {},
		--cond = function() return false end,
		lazy = false,
		opts = {
			-- exclude directories from session creation
			exclude_dirs = { "/home/aporia" },
			autosave = {
				enabled = true,
				interval = 60,
				notify = false,
			},
		},
		config = function(_, opts)
			local resession = require("resession")
			resession.setup(opts)

			-- create session from current directory on exit
			vim.api.nvim_create_autocmd("VimLeavePre", {
				desc = "Resession: save dirsession",
				callback = function()
					resession.save(
						vim.fn.getcwd(),
						{ dir = "dirsession", notify = true }
					)
				end,
			})

			-- Always save a special session named "last"
			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "Resession: create directory sessions",

				callback = function()
					-- Only load the session if nvim was started with no args
					if vim.fn.argc(-1) == 0 then
						-- apply opts.exclude_dirs

						--local cwd = vim.fn.getcwd()
						-- for _, dir in ipairs(opts.exclude_dirs) do
						-- 	if dir == cwd then
						-- 		return
						-- 	end
						-- end

						-- Save these to a different directory, so our manual sessions don't get polluted
						resession.load(
							vim.fn.getcwd(),
							{ dir = "dirsession", silence_errors = false }
						)
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
