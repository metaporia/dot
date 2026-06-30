-- # Claude-generated

-- cmp-nvim-lsp is lazy but lazy.nvim's module loader handles the require here
-- since this file runs after lazy.setup() in init.lua

-- local caps = require("cmp_nvim_lsp").default_capabilities()
-- caps.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
-- vim.lsp.config("*", { capabilities = caps })

vim.lsp.enable({
  "lua_ls",
  "bashls",
  "clangd",
  "nixd",
  "pyright",
  "emmet_language_server",
})

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { prefix = "●" },
  severity_sort = true,
})

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostic open float" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set loclist with diagnostics" })
vim.keymap.set("n", "<space>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

local function set_hl_for_floating_window()
  vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
end

set_hl_for_floating_window()
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  desc = "Avoid overwritten by loading color schemes later",
  callback = set_hl_for_floating_window,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local function opts(description)
      return { buffer = ev.buf, desc = description }
    end

    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts("Toggle Inlay Hints"))

    vim.keymap.set({ "n", "v" }, "gD", vim.lsp.buf.declaration, opts("Go to declaration (LSP)"))
    vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition, opts("Go to definition (LSP)"))
    vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, opts("Hover (LSP)"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation (LSP)"))
    vim.keymap.set({ "n", "v" }, "gk", vim.lsp.buf.signature_help, opts("Signature help (LSP)"))
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder (LSP)"))
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder (LSP)"))
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("List workspace folders (LSP)"))
    vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, opts("Type definition (LSP)"))
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts("Rename (LSP)"))
    vim.keymap.set({ "n", "v" }, "<space>a", vim.lsp.buf.code_action, opts("Code action (LSP)"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Quickfix references (LSP)"))
  end,
})
