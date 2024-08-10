return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufWritePre" },
		cmd = "ConformInfo",

		--init = function()
		--  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		--end

		keys = {
			{
				"<space>f",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format",
			},
		},

		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
