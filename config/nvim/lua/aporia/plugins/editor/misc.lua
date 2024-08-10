return {

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
			npairs.add_rules({
				rule("|", "|", { "rust", "lua" }):with_move(cond.after_regex("|")),
			})
		end,

		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
}
