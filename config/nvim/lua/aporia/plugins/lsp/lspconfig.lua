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
		-- the spec for nvim-lspconfig is split into multiple files, one per
		-- language. The top lovel spec ./lsp.lua collects and merges the `opts`
		-- tables for each language server
		opts = {
			-- put any servers you want installed by default here, otherwise put them
			-- in a language specific file in ./lsp
			servers = {
				lua_ls = {},
				bashls = {},
				clangd = {},
        -- hls = {}
			},
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
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")

			local lsp_defaults = lspconfig.util.default_config

			local caps = vim.tbl_deep_extend(
				"force",
				--lsp_defaults.capabilities,
				vim.lsp.protocol.make_client_capabilities(), -- does this work
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- ###########
			-- # SERVERS #
			-- ###########
			for server, server_opts in pairs(opts.servers) do
				server_opts.capabilities = caps
				lspconfig[server].setup(server_opts)
			end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set(
				"n",
				"<space>e",
				vim.diagnostic.open_float,
				{ desc = "Diagnostic open float" }
			)
			vim.keymap.set(
				"n",
				"<space>q",
				vim.diagnostic.setloclist,
				{ desc = "Set loclist with diagnostics" }
			)
			vim.keymap.set("n", "<space>td", function()
				vim.diagnostic.enable(not vim.diagnostic.is_enabled())
			end, { desc = "Toggle diagnostics" })

			-- Add border to lsp floating windows
			local float_opts = { border = "rounded"}

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

			-- vim.lsp.handlers["textDocument/signatureHelp"] =
			-- 	vim.lsp.with(vim.lsp.handlers.signature_help, {
			-- 		border = _border,
			-- 	})

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local function per_buffer_with_desc(description)
            return { buffer = ev.buf, desc = description }
          end
          vim.keymap.set(
            { "n", "v" },
            "gD",
            vim.lsp.buf.declaration,
            per_buffer_with_desc("Go to declaration (Lsp)")
          )
          vim.keymap.set(
            { "n", "v" },
            "gd",
            vim.lsp.buf.definition,
            per_buffer_with_desc("Go to definition (LSP)")
          )
          vim.keymap.set(
            { "n", "v" },
            "K",
            function ()
              vim.lsp.buf.hover(float_opts)
            end,
            per_buffer_with_desc("Hover (LSP)")
          )
          vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            per_buffer_with_desc("Go to implementation (LSP)")
          )
          vim.keymap.set(
            { "n", "v" },
            "gk",
            function ()
            vim.lsp.buf.signature_help(float_opts)
            end,
            per_buffer_with_desc("Signature help (LSP)")
          )
          vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            per_buffer_with_desc("Add workspace folder (LSP)")
          )
          vim.keymap.set(
            "n",
            "<space>wr",
            vim.lsp.buf.remove_workspace_folder,
            per_buffer_with_desc("Remove workspace folder (LSP)")
          )
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, per_buffer_with_desc("List workspace folders (LSP)"))
          vim.keymap.set(
            "n",
            "<space>d",
            vim.lsp.buf.type_definition,
            per_buffer_with_desc("Type definition (LSP)")
          )
          vim.keymap.set(
            "n",
            "<space>rn",
            vim.lsp.buf.rename,
            per_buffer_with_desc("Rename (LSP)")
          )
          vim.keymap.set(
            { "n", "v" },
            "<space>a",
            vim.lsp.buf.code_action,
            per_buffer_with_desc("Code action (LSP)")
          )
          vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            per_buffer_with_desc("Quickfix references (LSP)")
          )
          --vim.keymap.set('n', '<space>f', function()
          --  vim.lsp.buf.format { async = true }
          --end, opts('Format (LSP)'))
        end,
      })
    end,
  },

	-- {
	-- 	"tamago324/nlsp-settings.nvim",
	-- 	opts = {
	-- 		config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
	-- 		local_settings_dir = ".nlsp-settings",
	-- 		local_settings_root_markers_fallback = { ".git" },
	-- 		append_default_schemas = true,
	-- 		loader = "json",
	-- 	},
	-- },
}
