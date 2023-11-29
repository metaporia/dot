-- default plugin spec. all files in ../plugins/ will be merged into single
-- spec and loaded by lazy.nvim
return {

  {
    'jdhao/better-escape.vim',
    config = function()
      -- default timout is 150ms
      vim.g.better_escape_interval = 200
      vim.g.better_escape_shortcut = 'jk'
    end
  },

  {
    'kylechui/nvim-surround',
    config = function()
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
        scope = {
          highlight = { "Function", "Label" },
          include = { node_type = { nix = { "attrset_expression" } } },
        },
      }
    end
  },

  ------------------
  -- COLORSCHEMES --
  ------------------

  {
    'tiagovla/tokyodark.nvim', -- TODO replace with folke's?
    opts = {},
    config = function(_, opts)
      --require("tokyodark").setup(opts)
      --vim.cmd [[colorscheme tokyodark]]
    end
  },

  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'darker',

      }
      --require('onedark').load()
    end
  },

  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.o.background = 'dark'
      vim.g.gruvbox_material_background = 'hard' -- hard, medium, soft
      vim.cmd [[colorscheme gruvbox-material]]
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

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },

  {
    'echasnovski/mini.surround',
    version = '*',
    lazy = false,
    config = function()
      require('mini.surround').setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  {
    'metaporia/dico-vim',
    lazy = false,
    init = function()
      vim.g.dico_vim_map_keys = 1
    end
  },

  {
    -- TODO lazy load
    url = 'https://gitlab.com/metaporia/muse-vim',
    lazy = false,
    init = function()
      vim.g.muse_vim_log_dir = "~/sputum/muse"
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = "BufRead",
    config = function()
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
    "Robitx/gp.nvim",
    config = function()
      local conf = {
        -- chat_model = "gpt-3.5",
      }
      require('gp').setup(conf)
    end
  },

  -- lspconfig revision
  -- desiderata:
  -- - auto completion
  -- - snippets
  -- - root detection
  -- - formatting
  -- - treesitter texobjects
  --
  --{ "folke/neodev.nvim", },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      -- "folke/neodev.nvim",
    },
    config = function()
      -- require('neodev').setup({ })
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

      local lsp_defaults = lspconfig.util.default_config

      local caps = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      lspconfig.clangd.setup({
        capabilities = caps,
      })
      lspconfig.nil_ls.setup {
        capabilities = caps,
        settings = {
          ['nil'] = {
            formatting = { command = { "nixpkgs-fmt" } },
            nix = {
              autoEvalInputs = true,
            },

          },
        },
      }
      lspconfig.lua_ls.setup {
        -- on_attach = on_attach,
        capabilities = caps,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
          }
        },
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path .. '/.luarc.json')
              and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
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
            client.notify("workspace/didChangeConfiguration",
              { settings = client.config.settings })
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

      vim.diagnostic.config {
        float = { border = _border }
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
          vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
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
      --'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      --vim.o.completopt = 'menu,menuone,noselect'
      --
      local cmd_keymap = {
        ["<C-e>"] = cmp.mapping(function(_)
          cmp.confirm({ select = true })
        end, { 'i', 'c', 's' }),
        ['<Tab>'] = cmp.mapping(function(_)
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end, { 'i', 'c', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 'c', 's' }),
      }
      cmp.setup({
        experimental = {
          ghost_text = true,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            select = false, -- if true,
            bahavior = cmp.ConfirmBehavior.Insert }),
          ["<C-y>"] = cmp.mapping.abort(),
          ["<C-e>"] = cmp.mapping.confirm( {select = true}),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
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
          -- TODO: fix for gruvbox
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered({
            -- winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None' -- old
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
          }),
        },

        sources = cmp.config.sources({
          { name = 'nvim_lsp', },
          { name = 'buffer', },
          { name = 'luasnip', },
          { name = 'path', },
        }),
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`,
        -- this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmd_keymap,
          sources = {
            { name = 'buffer' }
          }
        }),


        cmp.setup.cmdline(':', {
          mapping = cmd_keymap,
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
      })
    end
  },
}
