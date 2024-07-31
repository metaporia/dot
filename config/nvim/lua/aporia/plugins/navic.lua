return {
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    lazy = true,
    init = function()
      local util = require('aporia.util')
      util.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        lsp = { auto_attach = true },
        separator = " ",
        highlight = true,
        lazy_update_context = true,
      }
    end

  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)

      local component = {
        function()
          return require("nvim-navic").get_location()
        end,
        cond = function()
          return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
        end,
      }
      table.insert(opts.winbar.lualine_c, component)
      table.insert(opts.inactive_winbar.lualine_c, component)
    end
  },

  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   config = true,
  --   event = { "WinLeave" },
  --   only_line_seq = true,
  -- },

}
