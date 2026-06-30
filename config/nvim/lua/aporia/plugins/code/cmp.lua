return {
	-- TODO: completion disiderata:
	-- smart tab copmletion
	-- signature-help (c-s) (open docs, and keep open while typing signature)
	-- doc preview scrolling binds
	-- cmd-line smart c-n/c-p, cycle completion opens when in completion window
	-- (enter with tab)
	-- pick option: c-e, abort selection:  c-y ()
	-- snippets (native?)
	-- preview window positioning
	-- completion window border
	-- c-g or c-c to cancel and exit completion menu
	-- completion and doc preview ovelap in function signatures

	-- blink.nvim
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"saghen/blink.lib",
			-- optional: provides snippets for the snippet source
			"rafamadriz/friendly-snippets",
		},

		-- nixos
		build = function(plugin)
			vim
				.system({
					"nix",
					"shell",
					"nixpkgs#cargo",
					"nixpkgs#rustc",
					"nixpkgs#gcc",
					"nixpkgs#git",
					"--command",
					"sh",
					"-c",
					"cargo build --release && mkdir -p lib && cp target/release/libblink_cmp_fuzzy.so lib/libblink_cmp_fuzzy.so.$(git rev-parse --short HEAD)",
				}, { cwd = plugin.dir })
				:wait()
		end,

		-- build = function()
		-- 	-- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
		-- 	-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
		-- 	require("blink.cmp").build() --:pwait()
		-- end,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			--

			appearance = {},

      -- old nvim-cmp tab behavior:
      --["<Tab>"] = cmp.mapping(function(fallback)
      --  if cmp.visible() then
      --    cmp.select_next_item()
      --  elseif luasnip.expand_or_jumpable() then
      --    luasnip.expand_or_jump()
      --  elseif has_words_before() then
      --    cmp.complete()
      --  else
      --    fallback()
      --  end

			keymap = {
				preset = "super-tab", -- gives C-n/p, C-b/f scroll, C-space open
				["<C-e>"] = { "select_and_accept" }, -- pick (was cancel in default)
				["<C-y>"] = { "cancel" }, -- abort (was accept in default)
				["<C-g>"] = { "cancel" }, -- abort (was accept in default)
				-- ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
				-- ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				list = {
					selection = {
						-- preselect = true,
						auto_insert = false,
					},
				},
				-- FIXME: ghost text too faint
				ghost_text = {
					enabled = true,
					show_with_menu = true,
					show_without_menu = true,
				},

				menu = {
          scrollbar = false,
					border = "rounded",
					-- auto_show = true,
					-- auto_show_delay_ms = 500,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon" },
						},
					},
				},

				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},

			-- (Default) list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = { default = { "lsp", "path", "snippets", "buffer" } },

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"`
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust" },
			signature = { enabled = true, window = { border = "rounded" } },

			-- cmdline
      -- FIXME: different tab behavior in cmdline rn. this is not great
      --
			cmdline = {
				keymap = {
					-- preset = "inherit",
					["<C-e>"] = { "select_and_accept" }, -- pick (was cancel in default)
					["<C-y>"] = { "cancel" }, -- abort (was accept in default)
					["<C-g>"] = { "cancel" }, -- abort (was accept in default)
				},
			},
		},
	},

	-- TODO: fix dependency order/factorize lsp & cmp config
	-- see: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua
	-- nvim-cmp (disabled)
	{
		enabled = false,
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			--'hrsh7th/cmp-nvim-lua',
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			--'saadparwaiz1/cmp_luasnip',
			--'L3MON4D3/LuaSnip',
			--'mrcjkb/haskell-snippets.nvim'
		},
		opts = function()
			local cmp = require("cmp")
			--local cmp_buffer = require("cmp_buffer")
			--local luasnip = require 'luasnip'

			-- from luansip supertab config
			--local has_words_before = function()
			--  unpack = unpack or table.unpack
			--  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			--  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			--end

			--vim.o.completopt = 'menu,menuone,noselect'
			--
			local cmd_keymap = {
				["<C-y>"] = cmp.mapping.abort(),
				["<C-e>"] = cmp.mapping(function(_)
					cmp.confirm({ select = true })
				end, { "i", "c", "s" }),
				["<Tab>"] = cmp.mapping(function(_)
					if cmp.visible() then
						cmp.select_next_item()
					else
						cmp.complete()
					end
				end, { "i", "c", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "c", "s" }),

				--['<C-n>'] = cmp.mapping(function(fallback)
				--  if cmp.visible() then
				--    cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
				--  else
				--    fallback()
				--  end
				--end, { 'i', 'c', 's' }),
				--['<C-P>'] = cmp.mapping(function(fallback)
				--  if cmp.visible() then
				--  cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
				--  else
				--    fallback()
				--  end
				--end, { 'i', 'c', 's' }),
			}

			-- close completion menu when opening cmdline window from cmdline with
			-- `<C-f>`
			vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
				pattern = { "*" },
				callback = function()
					cmp.close()
				end,
			})

			return {
				formatting = {
					-- TODO: move to rust config? as it only breaks there
					--expandable_indicator = true,
					format = function(_, vim_item)
						vim_item.menu = nil
						return vim_item
					end,
					fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind },
					expandable_indicator = true,
				},

				experimental = {
					ghost_text = true,
				},
				--snippet = {
				--  expand = function(args)
				--    luasnip.lsp_expand(args.body)
				--  end
				--},
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					}),
					["<C-p>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
					}),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						select = false, -- if true,
						bahavior = cmp.ConfirmBehavior.Insert,
					}),
					["<C-y>"] = cmp.mapping.abort(),
					["<C-e>"] = cmp.mapping.confirm({ select = true }),
					--["<Tab>"] = cmp.mapping(function(fallback)
					--  if cmp.visible() then
					--    cmp.select_next_item()
					--  elseif luasnip.expand_or_jumpable() then
					--    luasnip.expand_or_jump()
					--  elseif has_words_before() then
					--    cmp.complete()
					--  else
					--    fallback()
					--  end
					--end, { 'i', 's' }),
					--['<S-Tab>'] = cmp.mapping(function(fallback)
					--  if cmp.visible() then
					--    cmp.select_prev_item()
					--  elseif luasnip.jumpable(-1) then
					--    luasnip.jump(-1)
					--  else
					--    fallback()
					--  end
					--end, { 'i', 's' }),
				},

				window = {
					-- TODO: fix for gruvbox
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered({
						-- winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None' -- old
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
					}),
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					--{ name = 'nvim_lua', },
					-- Complete words from all open buffers
					-- TODO: disable completion of words from buffers opened with, e.g.,
					-- K or goto source
					{
						name = "buffer",
						keyword_length = 3,

						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					--{ name = 'omni', },
					{ name = "path" },

					-- TODO: tmux completions
				}),

				-- TODO
				-- * if completion window visible, C-n/p navigate completion
				-- suggestions rather than command history.
				cmp.setup.cmdline(":", {
					--mapping = cmp.mapping.preset.cmdline(),
					mapping = cmd_keymap,
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{ name = "cmdline" },
					}),
				}),

				-- Use buffer source for `/` and `?` (if you enabled `native_menu`,
				-- this won't work anymore).
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmd_keymap,
					sources = {
						{ name = "buffer" },
					},
				}),
			}
		end,
	},
}
