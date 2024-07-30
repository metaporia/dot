-- default plugin spec. all files in ../plugins/ will be merged into single
-- spec and loaded by lazy.nvim
return {
  --
  --  {
  --    "mfussenegger/nvim-dap",
  --    lazy = true,
  --    config = true,
  --    keys = {
  --
  --      {
  --        '<F5>',
  --        function() require('dap').continue() end,
  --        mode = { "n" },
  --        desc = "continue (DAP)"
  --      },
  --      {
  --        '<F6>',
  --        function() require('dap').step_into() end,
  --        mode = { "n" },
  --        desc = "step into (DAP)"
  --      },
  --      {
  --        '<F7>',
  --        function() require('dap').step_over() end,
  --        mode = { "n" },
  --        desc = "step over (DAP)"
  --      },
  --      {
  --        '<F8>',
  --        function() require('dap').step_out() end,
  --        mode = { "n" },
  --        desc = "step out (DAP)"
  --      },
  --      {
  --        '<space>dp',
  --        function() require('dap').pause() end,
  --        mode = { "n" },
  --        desc = "pause (DAP)"
  --      },
  --
  --      {
  --        '<space>dl',
  --        function() require('dap').run_last() end,
  --        mode = { "n" },
  --        desc = "run last (DAP)"
  --      },
  --      {
  --        '<space>dt',
  --        function() require('dap').toggle_breakpoint() end,
  --        mode = { "n" },
  --        desc = "toggle breakpoint (DAP)"
  --      },
  --    },
  --  },
  --
  --  {
  --    "rcarriga/nvim-dap-ui",
  --    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  --    lazy = true,
  --    config = true,
  --    keys = {
  --      {
  --        '<space>do',
  --        function() require('dapui').toggle() end
  --        ,
  --        mode = { 'n' },
  --        desc = 'toggle (dap-ui)'
  --      },
  --      {
  --        '<M-d>',
  --        function() require('dapui').eval() end
  --        ,
  --        mode = { 'n', 'v' },
  --        desc = 'close (dap-ui)'
  --      },
  --      --{
  --      --  '<space>do',
  --      --  function() require('dapui').open() end
  --      --  ,
  --      --  mode = { 'n' },
  --      --  desc = 'open (dap-ui)'
  --      --},
  --      --{
  --      --  '<space>do',
  --      --  function() require('dapui').open() end
  --      --  ,
  --      --  mode = { 'n' },
  --      --  desc = 'open (dap-ui)'
  --      --},
  --    },
  --  },

  {
    "chrishrb/gx.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    submodules = false,
    opts = {
      handlers = {
        plugin = true,
        search = true, -- just google it as fallback
      }
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local opts = {
        check_ts = true, -- check treesitter
        map_c_h = true,
        map_c_w = true
      }
      require("nvim-autopairs").setup({ opts })
      local npairs = require("nvim-autopairs")
      local rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      npairs.add_rules({ rule("|", "|"
      , { "rust", "lua" }):with_move(cond.after_regex("|")) })
    end

    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function


  },

  {
    "folke/trouble.nvim",
    opts = {
      auto_preview = false,
      preview = {
        --type = "split",
        --relative = "win",

      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "folke/todo-comments.nvim",

    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,          -- show signs in column
      merge_keywords = true, -- merge opts.keywords with default table
      keywords = {
        TMP = { icon = "⏲ ", color = "test" },
      },

      highlight = {
        comments_only = false, -- use treesitter
      },

    }
  },

  {
    'ziontee113/color-picker.nvim',
    ft = { 'css' },

    config = function()
      local opts = { noremap = true, silent = true }

      -- TODO sensible leader prefix for misc bindings
      vim.keymap.set("n", "<leader>fc", "<cmd>PickColor<cr>", opts)
      -- vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

      require("color-picker").setup({ -- for changing icons & mappings
        -- ["icons"] = { "ﱢ", "" },
        -- ["icons"] = { "ﮊ", "" },
        -- ["icons"] = { "", "ﰕ" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "", "" },
        ["icons"] = { "ﱢ", "" },
        ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        ["keymap"] = {          -- mapping example:
          ["U"] = "<Plug>ColorPickerSlider5Decrease",
          ["O"] = "<Plug>ColorPickerSlider5Increase",
        },
        ["background_highlight_group"] = "Normal",  -- default
        ["border_highlight_group"] = "FloatBorder", -- default
        ["text_highlight_group"] = "Normal",        --default
      })
    end

  },

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
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      local util = require('tokyonight.util')
      return {
        style = 'night',
        on_highlights = function(highlights, colors)
          highlights.WinSeparator = {
            bold = true,
            fg = util.darken(colors.purple, 0.6),
          }
        end
      }
    end,

  },

  {
    'navarasu/onedark.nvim',
    opts = { style = 'darker' },
  },

  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.o.background = 'dark'
      vim.g.gruvbox_material_background = 'hard' -- hard, medium, soft
      --vim.cmd
    end
  },

  {
    'nvim-lualine/lualine.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts =
    {
      options = {
        theme = 'tokyonight',
        globalstatus = true,
      },

      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filename',
            path = 1
          }
        },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' }
      },
      winbar = {
        lualine_a = {
        },
        lualine_b = { 'filetype' },
        lualine_c = {
          {
            'filename',
            path = 4,
            --shorting_target = 50,
          }
        },
      },
      inactive_winbar = {
        lualine_a = {
        },
        lualine_b = { 'filetype' },
        lualine_c = {
          {
            'filename',
            path = 4,
            --shorting_target = 50,
          }
        },
      },

    }
  },

  {
    'nvim-telescope/telescope.nvim',
    tag          = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
    },


    opts = function()
      return {
        pickers = {
          buffers = {
            mappings = {
              -- TODO:
            },
          },
        },
        defaults = {
          layout_strategy = 'flex',
          layout_config = {
            -- TODO: make this dynamic based on width:height ratio
            flex = {
              flip_columns = 180,
            },
            preview_cutoff = 20,
            --vertical = { },
            --horizontal = { },
          },
        },
      }
    end,
    keys = {


      { '<leader>lf', "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { '<leader>lg', "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
      --{'<leader>lg', builtin.live_grep, {}) },
      {
        '<leader>lb',
        function() require('telescope.builtin').live_grep({ grep_open_files = true }) end,
        desc = "Live grep open files"
      },
      {
        '<leader>b',
        function()
          local builtin = require('telescope.builtin')
          local action_state = require('telescope.actions.state')
          builtin.buffers({
            --initial_mode = "normal",
            attach_mappings = function(prompt_bufnr, map)
              local delete_buf = function()
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                current_picker:delete_selection(function(selection)
                  vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                end)
              end

              map('n', '<c-k>', delete_buf)
              map('i', '<c-k>', delete_buf)

              return true
            end
          }, {
            sort_lastused = true,
            sort_mru = true,
            theme = "dropdown"
          })
        end
        ,
        desc = "Buffers"
      },
      { '<leader>lh', "<cmd>Telescope help_tags<cr>",                     desc = "Help tags" },
      { '<leader>lr', "<cmd>Telescope resume<cr>",                        desc = "Telescope Resume" },
      { '<space>s',   "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Telescope Workspace Symbols (LSP)" },

    },
  },


  {
    'echasnovski/mini.surround',
    config = true,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true,
  },

  {
    'metaporia/dico-vim',
    lazy = false,
    init = function()
      vim.g.dico_vim_map_keys = 1
      -- Trial to see whether to use dedicated key or leader plus repeat.
      -- A dedicated key is faster but the leader+repeat leaves more keys
      -- unmapped.
      vim.keymap.set('n',
        '<space>d',
        ":call Define('h', expand('<cword>'))<CR>",
        { noremap = true })
      vim.keymap.set('n',
        '<Leader>dd',
        ":call Define('h', expand('<cword>'))<CR>",
        { noremap = true })
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

  -- Non-lspconfig haskell plugin, handles lsp,
  -- see ~/.config/nvim/after/ftplugin/hasknll.lua for keymaps
  -- TODO: move to lazy plugin
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^3', -- Recommended
    dependencies = { 'nvim-telescope/telescope.nvim' },
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    -- for searching signature under cursor with hoogle, package-local file
    -- search, &c.
    config = function()
      require('telescope').load_extension('ht')
    end
  },


  {
    "Robitx/gp.nvim",
    lazy = true,
    config = true,
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
      --"folke/neodev.nvim",
    },
    config = function()
      --require('neodev').setup({
      --  override = function(root_dir, library)
      --    if root_dir:find("/home/aporia/dot/config/nvim", 1, true) == 1 then
      --      library.enabled = true
      --      library.plugins = true
      --    end
      --  end
      --})

      --
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

      lspconfig.nixd.setup({
        capabilities = caps,
      })

      lspconfig.lua_ls.setup {
        -- on_attach = on_attach,
        capabilities = caps,
        on_init = function(client)
          --local path = client.workspace_folders[1].name
          --if not vim.loop.fs_stat(path .. '/.luarc.json')
          --    and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              }
            },
            diagnostics = {
              globals = { "vim" },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_size = 2,
                max_line_length = 79,
              },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              --library = {
              --   https://stackoverflow.com/questions/75880481/cant-use-lua-lsp-in-neovim
              --  --(vim.env.VIMRUNTIME .. "/lua"),
              --  --(vim.fn.stdpath "data" .. "/lazy"), -- ~/.local/share/nvim
              --  --(vim.fn.stdpath "data" .. "/lazy"), -- ~/.local/share/nvim
              --  -- "${3rd}/luv/library"
              --  -- "${3rd}/busted/library",
              --},
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              library = vim.api.nvim_get_runtime_file("", true),
              hint = { enable = true }

            }
          })
          client.notify("workspace/didChangeConfiguration",
            { settings = client.config.settings })
          return true
        end,
        settings = { Lua = {} },
      }
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Goto prev diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Set loclist with diagnostics" })
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Set loclist with diagnostics" })
      vim.keymap.set('n', '<space>td',
        function()
          vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end, { desc = "Toggle diagnostics" })

      -- Add border to lsp floating windows
      local _border = "rounded"

      -- set normal background so it doesn't look square
      -- TODO move out of lspconfig?
      local set_hl_for_floating_window = function()
        vim.api.nvim_set_hl(0, 'NormalFloat', {
          link = 'Normal',

        })
        vim.api.nvim_set_hl(0, 'FloatBorder', {
          bg = 'none',
        })
      end

      set_hl_for_floating_window()

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        desc = 'Avoid overwritten by loading color schemes later',
        callback = set_hl_for_floating_window,
      })

      -- for square popups
      local __border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
      }
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
        float = { border = _border },
        virtual_text = { prefix = '●' }
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
          local function opts(description)
            return { buffer = ev.buf, desc = description }
          end
          vim.keymap.set({ 'n', 'v' }, 'gD', vim.lsp.buf.declaration, opts('Go to declaration (Lsp)'))
          vim.keymap.set({ 'n', 'v' }, 'gd', vim.lsp.buf.definition, opts('Go to definition (LSP)'))
          vim.keymap.set({ 'n', 'v' }, 'K', vim.lsp.buf.hover, opts('Hover (LSP)'))
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts('Go to implementation (LSP)'))
          vim.keymap.set({ 'n', 'v' }, 'gk', vim.lsp.buf.signature_help, opts('Signature help (LSP)'))
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts('Add workspace folder (LSP)'))
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts('Remove workspace folder (LSP)'))
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts('List workspace folders (LSP)'))
          vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, opts('Type definition (LSP)'))
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts('Rename (LSP)'))
          vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts('Code action (LSP)'))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts('Quickfix references (LSP)'))
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts('Format (LSP)'))
        end,
      })
    end
  },

  -- TODO: fix dependency order/factorize lsp & cmp config
  -- see: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'mrcjkb/haskell-snippets.nvim'
    },
    config = function()
      local cmp = require 'cmp'
      local cmp_buffer = require('cmp_buffer')
      local luasnip = require 'luasnip'
      -- does this lazy load or doesn't it matter for snippets?
      local haskell_snippets = require('haskell-snippets').all
      --luasnip.add_snippets('haskell', haskell_snippets, { key = 'haskell' })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      --vim.o.completopt = 'menu,menuone,noselect'
      --
      local cmd_keymap = {
        ["<C-y>"] = cmp.mapping.abort(),
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

        --['<C-n>'] = cmp.mapping(function(fallback)
        --  if cmp.visible() then
        --    cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --  else
        --    fallback()
        --  end
        --end, { 'i', 'c', 's' }),
        --['<C-P>'] = cmp.mapping(function(fallback)
        --  if cmp.visible() then
        --  cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --  else
        --    fallback()
        --  end
        --end, { 'i', 'c', 's' }),
      }


      -- close completion menu when opening cmdline window from cmdline with
      -- `<C-f>`
      vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
        pattern = { "*" },
        callback = function()
          cmp.close()
        end
      })

      cmp.setup({
        formatting = {
          -- TODO: move to rust config? as it only breaks there
          --expandable_indicator = true,
          format = function(entry, vim_item)
            vim_item.menu = nil
            return vim_item
          end,
          fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind }
        },

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
            bahavior = cmp.ConfirmBehavior.Insert
          }),
          ["<C-y>"] = cmp.mapping.abort(),
          ["<C-e>"] = cmp.mapping.confirm({ select = true }),
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

        -- from cmp-buffer, may break comparators
        --sorting = {
        --  priority_weight = 2,
        --

        --  comparators = {
        --    function (...) return cmp_buffer:compare_locality(...) end,
        --  },
        --},

        sources = cmp.config.sources({
          { name = 'nvim_lsp', },
          { name = 'luasnip', },
          { name = 'nvim_lua', },
          -- Complete words from all open buffers
          -- TODO: disable completion of words from buffers opened with, e.g.,
          -- K or goto source
          {
            name = 'buffer',
            keyword_length = 3,

            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
          --{ name = 'omni', },
          { name = 'path', },

          -- TODO: tmux completions
        }),
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`,
        -- this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmd_keymap,
          sources = {
            { name = 'buffer' }
          }
        }),


        -- TODO
        -- * if completion window visible, C-n/p navigate completion
        -- suggestions rather than command history.
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


  -- resession
  {
    -- NOTE: this kind of plugin spec extension/override must come /after/ the
    -- plugin it is extending
    "nvim-telescope/telescope.nvim",
    dependencies = { "scottmckendry/telescope-resession.nvim" },
    keys = {
      {
        "<leader>ll",
        function() require('telescope').extensions.resession.resession() end,
        desc = "Telescope resession"
      }
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {},
        {
          extensions = {

            resession = {
              path_substitutions = { { find = "/home/aporia", replace = "~" }, },
              prompt_title = "Sessions",
              dir = "session"
            }
          }
        })
    end

  },

  {
    'stevearc/resession.nvim',
    dependencies = {},
    lazy = false,
    config = function()
      local opts = {
        autosave =
        {
          enabled = true,
          interval = 60,
          notify = true,
        },
      }
      local resession = require('resession')
      resession.setup(opts)

      -- Always save a special session named "last"
      vim.api.nvim_create_autocmd("VimLeavePre", {
        desc = "Resession: save last & save dirsession",
        callback = function()
          resession.save("last")
          resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
        end,
      })

      -- Always save a special session named "last"
      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Resession: create directory sessions",

        callback = function()
          -- Only load the session if nvim was started with no args
          if vim.fn.argc(-1) == 0 then
            -- Save these to a different directory, so our manual sessions don't get polluted
            resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
          end
        end,
        nested = true,
      })

      vim.keymap.set("n", "<leader>ss", resession.save)
      vim.keymap.set("n", "<leader>sl", resession.load)
      vim.keymap.set("n", "<leader>sd", resession.delete)

      --vim.api.nvim_create_user_command('')
    end,
  },


}
