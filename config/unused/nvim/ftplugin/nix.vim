setlocal formatprg=nixfmt
" TODO needs to detect various types of project roots and write tags only to
" the toplevel--we don't want subdirectories littered with tag files.
au! BufWritePost *.nix silent !nix-doc tags
