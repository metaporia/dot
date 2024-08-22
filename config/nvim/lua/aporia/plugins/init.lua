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
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next({keywords = {"FIXME", "TODO"}})
				end,
				{ mode = "n", desc = "Next todo comment" },
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev({keywords = {"FIXME", "TODO"}})
				end,
				{ mode = "n", desc = "Previous todo comment" },
			},
		},
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
		"echasnovski/mini.surround",
		config = true,
	},

	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "folke/tokyonight.nvim" },
		event = { "BufReadPost", "BufWritePre", "BufNewFile" },
		opts = function()
			vim.cmd([[:highlight GitSignsAdd guifg=#A4CF69]])
			vim.cmd([[:highlight GitSignsChange guifg=#63c1e6]])
			vim.cmd([[:highlight GitSignsDelete guifg=#d74f56]])

			return {
				signs = {
					add = { text = "┃", h1 = "GitSignsAdd" },
					change = { text = "┃", h1 = "GitSignsChange" },
					delete = { text = "", h1 = "GitSignsDelete" },
					topdelete = { text = "", h1 = "GitSignsTopDelete" },
					changedelete = { text = "┃", h1 = "GitSignsChangeDelete" },
					untracked = { text = "┃", h1 = "GitSignsUntracked" },
				},
				signs_staged = {
					add = { text = "┃", h1 = "GitSignsAdd" },
					change = { text = "┃", h1 = "GitSignsChange" },
					delete = { text = "", h1 = "GitSignsDelete" },
					topdelete = { text = "┃" }, -- h1 ="GitSignsTopDelete" }, --text = "" ,
					changedelete = { text = "┃" },
				},
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				end,
			}
		end,
	},

	{
		"metaporia/dico-vim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>dd",
				"<cmd>silent call Define('h', expand('<cword>'))<CR>",
				desc = "Define word",
			},
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
		"norcalli/nvim-colorizer.lua",
		cmds = { "ColorizerToggle", "ColorizerAttachToBuffer" },
		--ft = { "lua" },
		config = true,
	},
}
