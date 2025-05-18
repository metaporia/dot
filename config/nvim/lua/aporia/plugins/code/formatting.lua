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
        mode = "",
				desc = "Format",
			},
		},

    opts = {
      log_level = vim.log.levels.TRACE,
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        norg = { "norg_fmt" },
        bash = { "shfmt" },
        python = { "black" },
        sh = { "shfmt" },
        html = { "html_beautify" },
        css = { "css_beautify" },
        js = { "js_beautify"},
        nix = {"nixfmt"},
        -- run on filetypes without formatters
        ["_"] = { "trim_whitespace" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        html_beautify = {
          prepend_args = { "--indent-size", "2" },
        },
        js_beautify = {
          prepend_args = { "--indent-size", "2" },
        },
        css_beautify = {
          prepend_args = { "-p", "--indent_size", "2" },
        },
        norg_fmt = {
          command = "norg-fmt",
          args = { "--verify", "--newline-after-headings", "$FILENAME" },
        },
      },
    },
  },
}
-- vim.print(require('conform').get_formatter_config
