-- default plugin spec. all files in ../plugins/ will be merged into single
-- spec and loaded by lazy.nvim

return {

  { "folke/neodev.nvim",
    config = function ()
      require('neodev').setup({})
    end
  },

  {
    'kylechui/nvim-surround',
    config = function ()
      require("nvim-surround").setup()
    end

  },

  {
    'declancm/maximize.nvim',
    config = function()
      require('maximize').setup()
      vim.keymap.set('n', '<Leader>m', "<Cmd>lua require('maximize').toggle()<CR>")
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup {
        scope = { highlight = {"Function", "Label" }},
      }
    end
  },

  ------------------
  -- COLORSCHEMES -- 
  ------------------

  { 'tiagovla/tokyodark.nvim', -- TODO replace with folke's?
    opts = {},
    config = function(_, opts)
      require("tokyodark").setup(opts)
      vim.cmd [[colorscheme tokyodark]]
    end
  },

  { 'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'darker',

      }
      --require('onedark').load()
    end
  },

  { 'sainnhe/gruvbox-material',
    config = function()
      vim.o.background = 'dark'
      vim.g.gruvbox_material_background = 'hard' -- hard, medium, soft
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {}
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
  },

  { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },

  {
    'echasnovski/mini.surround',
    version = '*',
    lazy = false,
    config = function()
      require('mini.surround').setup()
    end
  },
  { 'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup ()
    end
  },

  {
    'metaporia/dico-vim',
    lazy = false,
    init = function ()
      vim.g.dico_vim_map_keys = 1
    end
  },

  {
    -- TODO lazy load
    url = 'https://gitlab.com/metaporia/muse-vim',
    lazy = false,
    init= function ()
      vim.g.muse_vim_log_dir = "~/sputum/muse"
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event="BufRead",
    config = function ()
      local configs = require 'nvim-treesitter.configs'
      configs.setup {
        -- TODO:
        --  * lua indent
        --  * cpp clangd, clang-format, indentation
        ensure_installed = { "cpp", "nix", "lua", "vim", "vimdoc", "query" },
        --auto_install = true,
        --ignore_install = { "javascript" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        }
      }
    end

  },


  {
    'neovim/nvim-lspconfig',
    config = function ()
      local lspconfig = require('lspconfig')

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


      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
          }
        },
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                  }
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
                }
              }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end
      }
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Add border to lsp floating windows
      local _border = "single"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = _border
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = _border
        }
      )

      vim.diagnostic.config{
        float={border=_border}
      }

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })


    end
  },

  { 'L3MON4D3/LuaSnip' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function ()
      local cmp = require'cmp'
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config
      local luasnip = require'luasnip'

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      lspconfig.clangd.setup({ })
      lspconfig.nil_ls.setup {
        capabilities = lsp_defaults.capabilities,
        settings = {
          ['nil'] = {
            testSetting = 42,
            --formatting = { "nixpkgs-fmt" },
          },
        },
      }


      cmp.setup( {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp', },
          { name = 'buffer', },
          { name = 'luasnip', },
          { name = 'path', },
        }),
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({select = true, bahavior = cmp.ConfirmBehavior.Replace}),
          ["<C-y>"] = cmp.mapping.confirm({select = false}),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's'}),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },

        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None'
          }),
        }
      })
    end
  },
}

