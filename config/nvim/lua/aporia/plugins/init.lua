-- default plugin spec. all files in ../plugins/ will be merged into single
-- spec and loaded by lazy.nvim

return { 
    { 
        'echasnovski/mini.surround', 
        version = '*', 
        lazy = false,
        config = function ()
            require('mini.surround').setup()
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
        url = 'https://gitlab.com/metaporia/muse-vim',
        lazy = false,
        init = function ()
            -- TODO add nix flake for muse
        end

    },


}

