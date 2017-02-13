if exists('b:current_syntax')
    finish
endif

au Bufread,BufNewfile *.txt set filetype=text
set wrap
set formatoptions=1
set linebreak
set nolist "list disables linebreak
