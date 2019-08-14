"execute 'lcd ' . expand('%:p:h')

nmap <buffer> K :call HoogleDok(expand('<cWORD>'))<CR>
nmap <buffer> <leader>h cswb%i :: _jk,w

setlocal tw=79
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal formatprg=brittany
let g:haskell_hlint_on_write = 0

au! BufWritePost *.hs silent !hasktags -bR .

if g:haskell_hlint_on_write
    au! BufWrite *.hs :silent Neomake hlint<CR>
endif

let g:ghcmod_ghc_options = ['-Wall', '-Wredundant-constraints', '-Wunused-binds', '-Wunused-imports', '-Wincomplete-record-updates', '-Wincomplete-uni-patterns', '-Wcompat']

let g:haskell_enable_quantification = 1
let g:haskell_enable_recursive_do = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1

" neco-ghc
let g:necoghc_use_stack = 1 
let g:necoghc_enable_detailed_browse = 1

if exists('*HoogleDok')
    finish
endif
function! HoogleDok(searchTerms)
    let wd = getcwd()
    execute 'silent lcd ' . expand('%:p:h')
    let query = "stack hoogle -- -i  \'" . a:searchTerms . "\'"  
    let info = system(query)
    let resize = "resize " . (winheight(0) * 1/4) 
    execute 'lcd ' . wd
    call DeadBuf('h') | exe resize | call bufname("HoogleDok") | setlocal ft=haskell | put =info
endfunction


