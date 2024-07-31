-- default plugin spec. all files in ../plugins/ will be merged into single
-- spec and loaded by lazy.nvim
return {
	--
	--  {
	--    "mfussenegger/nvim-dap",
	--    lazy = true,
	--    config = true,
	--    keys = {
	--
	--      {
	--        '<F5>',
	--        function() require('dap').continue() end,
	--        mode = { "n" },
	--        desc = "continue (DAP)"
	--      },
	--      {
	--        '<F6>',
	--        function() require('dap').step_into() end,
	--        mode = { "n" },
	--        desc = "step into (DAP)"
	--      },
	--      {
	--        '<F7>',
	--        function() require('dap').step_over() end,
	--        mode = { "n" },
	--        desc = "step over (DAP)"
	--      },
	--      {
	--        '<F8>',
	--        function() require('dap').step_out() end,
	--        mode = { "n" },
	--        desc = "step out (DAP)"
	--      },
	--      {
	--        '<space>dp',
	--        function() require('dap').pause() end,
	--        mode = { "n" },
	--        desc = "pause (DAP)"
	--      },
	--
	--      {
	--        '<space>dl',
	--        function() require('dap').run_last() end,
	--        mode = { "n" },
	--        desc = "run last (DAP)"
	--      },
	--      {
	--        '<space>dt',
	--        function() require('dap').toggle_breakpoint() end,
	--        mode = { "n" },
	--        desc = "toggle breakpoint (DAP)"
	--      },
	--    },
	--  },
	--
	--  {
	--    "rcarriga/nvim-dap-ui",
	--    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	--    lazy = true,
	--    config = true,
	--    keys = {
	--      {
	--        '<space>do',
	--        function() require('dapui').toggle() end
	--        ,
	--        mode = { 'n' },
	--        desc = 'toggle (dap-ui)'
	--      },
	--      {
	--        '<M-d>',
	--        function() require('dapui').eval() end
	--        ,
	--        mode = { 'n', 'v' },
	--        desc = 'close (dap-ui)'
	--      },
	--      --{
	--      --  '<space>do',
	--      --  function() require('dapui').open() end
	--      --  ,
	--      --  mode = { 'n' },
	--      --  desc = 'open (dap-ui)'
	--      --},
	--      --{
	--      --  '<space>do',
	--      --  function() require('dapui').open() end
	--      --  ,
	--      --  mode = { 'n' },
	--      --  desc = 'open (dap-ui)'
	--      --},
	--    },
	--  },


  -- overide vim.ui.select
	{
		"stevearc/dressing.nvim",
		opts = {},
	},

	{
		"chrishrb/gx.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		submodules = false,
		opts = {
			handlers = {
				plugin = true,
				search = true, -- just google it as fallback
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local opts = {
				check_ts = true, -- check treesitter
				map_c_h = true,
				map_c_w = true,
			}
			require("nvim-autopairs").setup({ opts })
			local npairs = require("nvim-autopairs")
			local rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			npairs.add_rules({ rule("|", "|", { "rust", "lua" }):with_move(cond.after_regex("|")) })
		end,

		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	{
		"folke/trouble.nvim",
		opts = {
			auto_preview = false,
			preview = {
				--type = "split",
				--relative = "win",
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "VeryLazy" },

		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true, -- show signs in column
			merge_keywords = true, -- merge opts.keywords with default table
			keywords = {
				TMP = { icon = "⏲ ", color = "test" },
			},

			highlight = {
				comments_only = false, -- use treesitter
			},
		},
	},

	{
		"ziontee113/color-picker.nvim",
		ft = { "css" },
		keys = {
			-- TODO: sensible leader prefix for misc bindings
			{ "<leader>fc", "<cmd>PickColor<cr>", desc = "Pick Color" },
		},
		opts = {
			-- for changing icons & mappings
			-- ["icons"] = { "ﱢ", "" },
			-- ["icons"] = { "ﮊ", "" },
			-- ["icons"] = { "", "ﰕ" },
			-- ["icons"] = { "", "" },
			-- ["icons"] = { "", "" },
			["icons"] = { "ﱢ", "" },
			["border"] = "rounded", -- none | single | double | rounded | solid | shadow
			["keymap"] = { -- mapping example:
				["U"] = "<Plug>ColorPickerSlider5Decrease",
				["O"] = "<Plug>ColorPickerSlider5Increase",
			},
			["background_highlight_group"] = "Normal", -- default
			["border_highlight_group"] = "FloatBorder", -- default
			["text_highlight_group"] = "Normal", --default
		},
	},

	{
		"jdhao/better-escape.vim",
		event = "InsertEnter",
		config = function()
			-- default timout is 150ms
			vim.g.better_escape_interval = 200
			vim.g.better_escape_shortcut = "jk"
		end,
	},

	-- {
	--   'kylechui/nvim-surround',
	--   config = function()
	--     require("nvim-surround").setup()
	--   end
	--
	-- },

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufWritePre", "BufNewFile" },
		config = function()
			require("ibl").setup({
				scope = {
					highlight = { "Function", "Label" },
					include = { node_type = { nix = { "attrset_expression" } } },
				},
			})
		end,
	},

	------------------
	-- COLORSCHEMES --
	------------------

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			local util = require("tokyonight.util")
			return {
				style = "night",
				on_highlights = function(highlights, colors)
					highlights.WinSeparator = {
						bold = true,
						fg = util.darken(colors.purple, 0.6),
					}
				end,
			}
		end,
	},

	-- {
	--   'navarasu/onedark.nvim',
	--   opts = { style = 'darker' },
	-- },

	-- {
	--   'sainnhe/gruvbox-material',
	--   config = function()
	--     vim.o.background = 'dark'
	--     vim.g.gruvbox_material_background = 'hard' -- hard, medium, soft
	--     --vim.cmd
	--   end
	-- },

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",

		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
				globalstatus = true,
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = { "diagnostics" },
				lualine_y = { "filetype" },
				lualine_z = { "progress", "location" },
			},
			winbar = {
				lualine_a = {},
				lualine_b = { "filetype" },
				lualine_c = {
					{
						"filename",
						path = 4,
						--shorting_target = 50,
					},
				},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = { "filetype" },
				lualine_c = {
					{
						"filename",
						path = 4,
						--shorting_target = 50,
					},
				},
			},
		},
	},

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
								local current_picker = action_state.get_current_picker(prompt_bufnr)
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

	{
		"echasnovski/mini.surround",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},

	{
		"metaporia/dico-vim",
		event = "VeryLazy",
		keys = {
			{ "<leader>dd", "<cmd>call Define('h', expand('<cword>'))<CR>", desc = "Define word" },
		},
		config = function()
			vim.g.dico_vim_map_keys = 1
			-- Trial to see whether to use dedicated key or leader plus repeat.
			-- A dedicated key is faster but the leader+repeat leaves more keys
			-- unmapped.
			--vim.keymap.set('n',
			--  '<space>d',
			--  ":call Define('h', expand('<cword>'))<CR>",
			--  { noremap = true })
			--vim.keymap.set('n',
			--  '<Leader>dd',
			--  ":call Define('h', expand('<cword>'))<CR>",
			--  { noremap = true })
		end,
		--init = function()
		--  vim.g.dico_vim_map_keys = 1
		--  -- Trial to see whether to use dedicated key or leader plus repeat.
		--  -- A dedicated key is faster but the leader+repeat leaves more keys
		--  -- unmapped.
		--  vim.keymap.set('n',
		--    '<space>d',
		--    ":call Define('h', expand('<cword>'))<CR>",
		--    { noremap = true })
		--  vim.keymap.set('n',
		--    '<Leader>dd',
		--    ":call Define('h', expand('<cword>'))<CR>",
		--    { noremap = true })
		--end
	},

	{
		-- TODO: rewrite in lua with setup() to lazy load
		url = "https://gitlab.com/metaporia/muse-vim",
		cmd = { "LogToday", "LogEntry", "LastRead" },
		init = function()
			vim.g.muse_vim_log_dir = "~/sputum/muse"
		end,
	},

	{
		"Robitx/gp.nvim",
		lazy = true,
		config = true,
	},

	-- resession
	{
		-- NOTE: this kind of plugin spec extension/override must come /after/ the
		-- plugin it is extending
		"nvim-telescope/telescope.nvim",
		dependencies = { "scottmckendry/telescope-resession.nvim" },
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

	{
		"stevearc/resession.nvim",
		dependencies = {},
		lazy = false,
		opts = {
			-- exclude directories from session creation
			exclude_dirs = { "/home/aporia/" },
			autosave = {
				enabled = true,
				interval = 60,
				notify = true,
			},
		},
		config = function(_, opts)
			local resession = require("resession")
			resession.setup(opts)

			-- Always save a special session named "last"
			-- vim.api.nvim_create_autocmd("VimLeavePre", {
			--   desc = "Resession: save last & save dirsession",
			--   callback = function()
			--     resession.save("last")
			--     resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
			--   end,
			-- })

			-- Always save a special session named "last"
			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "Resession: create directory sessions",

				callback = function()
					-- Only load the session if nvim was started with no args
					if vim.fn.argc(-1) == 0 then
						local cwd = vim.fn.getcwd()
						-- apply opts.exclude_dirs
						for i, dir in ipairs(opts.exclude_dirs) do
							if dir == cwd then
								return
							end
						end

						-- Save these to a different directory, so our manual sessions don't get polluted
						resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
					end
				end,
				nested = true,
			})

			vim.keymap.set("n", "<leader>ss", resession.save, { desc = "Resession save" })
			vim.keymap.set("n", "<leader>sl", resession.load, { desc = "Resession load" })
			vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Ression delete" })

			--vim.api.nvim_create_user_command('')
		end,
	},
}
