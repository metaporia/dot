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

" ghci send via tmux
function! GhciSend(cmd, reload)
    if a:reload
        execute 'silent !tmuxGhciSend -r ' . a:cmd
    else 
        execute 'silent !tmuxGhciSend ' . a:cmd
    endif
endfunction

command! -nargs=+ GhciSend call GhciSend("<args>", 1)
nnoremap <leader>gs :call GhciSend(expand('<cword>'), 1)<CR>


"use this binding to visualize the selection performed by the function: 
"> normal! ?^[a-zA-Z]\+<cr>v/^[a-zA-Z-]\+<cr>?^\s\{-1,}\(\s\)\@!<cr>g_
function! HaskellToplevelDeclaration()
    let l:magic = &magic
    set magic
    let l:declaration = '^[a-zA-Z]\+'
    let l:commentOrDeclartion = '^[a-zA-Z-]\+'
    let l:start = search(l:declaration, 'bWn')
    execute 'normal! '.l:start.'G0'

    "calculate end of function before including type signature
    let l:end = search(l:commentOrDeclartion, 'Wn') - 1

    " if the line above the first toplevl declaration is /not/ empty, then run
    " get the next start line matching `l:declaration`.
    let g:line_above = getline(l:start - 1)
    if g:line_above!~#'^\s\{-}$'
        let l:new_start = search(l:declaration, 'bWn')
        execute 'normal! '.l:new_start.'G0'
    endif
    "execute 'normal! '.l:start.'G0'
    execute 'normal! v'.l:end.'G'
    let l:trimmed_end = search('\s\{-1,}\(\s\)\@!', 'bWn')
    execute 'normal! 0'.l:trimmed_end.'Gg_'
    
    let &magic = l:magic
endfunction

xnoremap <buffer> <silent> af :<c-u>call HaskellToplevelDeclaration()<CR>
onoremap <buffer> <silent> af :<c-u>call HaskellToplevelDeclaration()<CR>

