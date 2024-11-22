return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
  opts = {
    servers = {
      pyright = {}
    }
  }
}
