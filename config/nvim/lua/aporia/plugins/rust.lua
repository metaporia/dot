return {
  -- from https://github.com/LazyVim/LazyVim/blob/da7b7738eb84b00c949f48afabebd39266e61d75/lua/lazyvim/plugins/extras/lang/rust.lua

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
    end,
  },

}
