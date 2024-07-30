return {
  -- from https://github.com/LazyVim/LazyVim/blob/da7b7738eb84b00c949f48afabebd39266e61d75/lua/lazyvim/plugins/extras/lang/rust.lua

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { "rust" },
    opts = {
      tools = {
        float_win_config = { auto_focus = true, border = 'rounded' },
      },
      server = {
        default_settings = {
          ['rust-analyzer'] = {
          },
        },


        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<space>d", function()
              vim.cmd.RustLsp('openDocs')
            end,
            { desc = "Open Cargo Docs (Rust)", silent = true, buffer = bufnr }
          )

          vim.keymap.set("n", "<space>e", function()
              vim.cmd.RustLsp('explainError')
            end,
            { desc = "Explain Error (Rust)", silent = true, buffer = bufnr }
          )


          vim.keymap.set("n", "<space>a", function()
              vim.cmd.RustLsp('codeAction')
            end,
            { desc = "Code Action (Rust)", silent = true, buffer = bufnr }
          )

          vim.keymap.set("n", "<space>rd", function()
              vim.cmd.RustLsp('renderDiagnostic')
            end,
            { desc = "Render Diagnostics (Rust)", silent = true, buffer = bufnr }
          )
        end

        --default_settings = {
        --["rust-analyzer"] = {
        --  keys = {
        --    { "<space>a",  "<cmd>RustLsp codeAction<cr>",        desc = "Code Actions (Rust)" },
        --    { "<space>d",  "<cmd>RustLsp openDocs<cr>",          desc = "Open docs.rs (Rust)" },
        --    { "<space>rd", "<cmd>RustLsp renderDiagnostics<cr>", desc = "Render Diagnostics (Rust)" },
        --  }
        --},
        --},
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force",
        {},
        opts or {})
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
    end,
  },

}
