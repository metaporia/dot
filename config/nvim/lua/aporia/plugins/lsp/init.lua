return {
	-- lspconfig revision
	-- desiderata:
	-- - auto completion
	-- - snippets
	-- - root detection
	-- - formatting
	-- - treesitter texobjects
	--
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			--"folke/neodev.nvim",
		},
		opts = function()
			return {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					float = { border = "rounded" },
					virtual_text = { prefix = "●" },
					severity_sort = true,
				},
				-- Lsp cursor word highlighting
				-- LazyVim custom feature
				--document_highlight = { enabled = true, }
			}
		end,
		config = function(_, opts)
			--require('neodev').setup({
			--  override = function(root_dir, library)
			--    if root_dir:find("/home/aporia/dot/config/nvim", 1, true) == 1 then
			--      library.enabled = true
			--      library.plugins = true
			--    end
			--  end
			--})

			--
			local lspconfig = require("lspconfig")

			--lspconfig.clangd.setup {
			--  on_attach = on_attach,
			--  --capabilities = lspconfig.capabilities,
			--  --cmd = {
			--  --  "clangd",
			--  --  "--background-index",
			--  --  "--suggest-missing-includes",
			--  --  "--all-scopes-completion",
			--  --  "--completion-stlye=detailed",
			--  --},
			--}

			local lsp_defaults = lspconfig.util.default_config

			local caps = vim.tbl_deep_extend(
				"force",
				--lsp_defaults.capabilities,
				vim.lsp.protocol.make_client_capabilities(), -- does this work
				require("cmp_nvim_lsp").default_capabilities()
			)

			lspconfig.clangd.setup({
				capabilities = caps,
			})

			lspconfig.nixd.setup({
				capabilities = caps,
			})

			lspconfig.lua_ls.setup({
				capabilities = caps,
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			})

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostic open float" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto prev diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set loclist with diagnostics" })
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set loclist with diagnostics" })
			vim.keymap.set("n", "<space>td", function()
				vim.diagnostic.enable(not vim.diagnostic.is_enabled())
			end, { desc = "Toggle diagnostics" })

			-- Add border to lsp floating windows
			local _border = "rounded"

			-- set normal background so it doesn't look square
			-- TODO move out of lspconfig?
			local set_hl_for_floating_window = function()
				vim.api.nvim_set_hl(0, "NormalFloat", {
					link = "Normal",
				})
				vim.api.nvim_set_hl(0, "FloatBorder", {
					bg = "none",
				})
			end

			set_hl_for_floating_window()

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				desc = "Avoid overwritten by loading color schemes later",
				callback = set_hl_for_floating_window,
			})

			-- for square popups
			local __border = {
				{ "🭽", "FloatBorder" },
				{ "▔", "FloatBorder" },
				{ "🭾", "FloatBorder" },
				{ "▕", "FloatBorder" },
				{ "🭿", "FloatBorder" },
				{ "▁", "FloatBorder" },
				{ "🭼", "FloatBorder" },
				{ "▏", "FloatBorder" },
			}
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = _border,
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = _border,
			})

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local function opts(description)
						return { buffer = ev.buf, desc = description }
					end
					vim.keymap.set({ "n", "v" }, "gD", vim.lsp.buf.declaration, opts("Go to declaration (Lsp)"))
					vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition, opts("Go to definition (LSP)"))
					vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, opts("Hover (LSP)"))
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation (LSP)"))
					vim.keymap.set({ "n", "v" }, "gk", vim.lsp.buf.signature_help, opts("Signature help (LSP)"))
					vim.keymap.set(
						"n",
						"<space>wa",
						vim.lsp.buf.add_workspace_folder,
						opts("Add workspace folder (LSP)")
					)
					vim.keymap.set(
						"n",
						"<space>wr",
						vim.lsp.buf.remove_workspace_folder,
						opts("Remove workspace folder (LSP)")
					)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts("List workspace folders (LSP)"))
					vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, opts("Type definition (LSP)"))
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts("Rename (LSP)"))
					vim.keymap.set({ "n", "v" }, "<space>a", vim.lsp.buf.code_action, opts("Code action (LSP)"))
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Quickfix references (LSP)"))
					--vim.keymap.set('n', '<space>f', function()
					--  vim.lsp.buf.format { async = true }
					--end, opts('Format (LSP)'))
				end,
			})
		end,
	},
}
