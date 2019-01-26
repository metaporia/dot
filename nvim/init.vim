" vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'agude/vim-eldar'
Plug 'vim-scripts/Sift'
Plug 'neomake/neomake'
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
"Plug 'junegunn/goyo.vim'
Plug 'chriskempson/base16-vim'
Plug 'rust-lang/rust.vim', {'for': 'rust' }
"Plug 'bitc/vim-hdevtools', {'for' : 'haskell'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'} 
"Plug 'eagletmt/ghcmod-vim', {'for': 'haskell' }
Plug 'eagletmt/neco-ghc', {'for': 'haskell' }
"Plug 'haskell/haskell-ide-engine', {'for': 'haskell'}
"Plug 'Twinside/vim-hoogle', {'for': 'haskell' }
Plug 'racer-rust/vim-racer', {'for': 'rust' }
Plug 'tpope/vim-surround'
Plug 'jreybert/vimagit'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  
"Plug 'tpope/vim-fugitive'
"Plug 'parsonsmatt/intero-neovim', {'for':'haskell'}
Plug 'zchee/deoplete-clang', {'for': 'c'}
Plug 'itchyny/vim-haskell-indent', {'for': 'haskell'}
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
"Plug 'vim-scripts/coq-syntax'
Plug 'tounaishouta/coq.vim', {'for': 'coq'},
"Plug 'trefis/coquille', {'for': 'coq'}

Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'}
Plug 'pbrisbin/vim-syntax-shakespeare',
"Plug 'Shougo/echodoc.vim'
"Plug 'luochen1990/rainbow'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'

Plug 'ndmitchell/ghcid', { 'rtp' : 'plugins/nvim' }

" Java dev: comment out 'for' qualifier
Plug 'dansomething/vim-eclim' , {'for': 'java'}
Plug 'LnL7/vim-nix' ", {'for': 'nix'}
autocmd! User goyo.vim echom 'Goyo is now loaded!'
call plug#end()

se updatetime=100 " gitgutter
au! BufWrite * GitGutter
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn

inoremap jk <ESC>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>

"leader
nnoremap \ ,
let mapleader = ","

se hidden
se ignorecase

" backup
se nobackup
se noswapfile
se nowritebackup

se smartcase
se smartindent

se mouse=a

se timeout
" mapping timeout
se timeoutlen=200
" keycode timeout
se ttimeoutlen=50

se tw=79

se breakindent
se noshowmode

let loaded_matchparen = 0
se lazyredraw
set wildignorecase

" FIXME
"se nostartofline

"show status line: always
set laststatus=2
"clear (if any) pre-existing value of 'statusline'
set statusline=
"far left; items accumlate rightwards
"time
set statusline=%{strftime(\"%m-%d\ [%H:%M]\")}
"full file path
set statusline+=\ %F\ 
"filetype, [RO] (opt), buf num
set statusline+=%y\ %r\ buf:[%n]
"FAR RIGHT; items accumulate leftwards
set statusline+=%=

"se cursorline

se number
se relativenumber
set pastetoggle=<F3>

set shell=sh

"sessions
set sessionoptions+=options,globals,curdir,buffers,help,winsize,



"COLORs n aesthetic bullcrap upon which I fixate

"if filereadable(expand("~/.vimrc_background"))
"    let base16colorspace=256
"    source ~/.vimrc_background
"endif
if has("termguicolors")
    set termguicolors
endif
"colo base16-google-light

" fix LineNr bg/fg contrast probem
function! MatchLineNrBgToGuibg()
    let main_bg_id=hlID('Normal')
    let main_guibg=synIDattr(main_bg_id, 'bg#', "gui")
    highlight LineNr guibg=main_guibg
endfunction

" set Hl-search to match IncSearch
function! SetSearchColorToIncSearch()
    let inc_search_id=hlID('IncSearch')
    let incs_bg=synIDattr(inc_search_id, 'bg#', "gui")
    let incs_fg=synIDattr(inc_search_id, 'fg#', "gui")
    execute 'highlight Search guibg=' . incs_bg . ' guifg=' . incs_fg 
endfunction

augroup FixSearchColor
    au!
    au ColorScheme * call SetSearchColorToIncSearch()
    au ColorScheme * call MatchLineNrBgToGuibg()
augroup END


"last recourse:    highlight clear LineNr

"copy/paste

"sys clip
"append motion to yank
"yank to sys clip
nnoremap <leader>c "+y
vnoremap <leader>c "+y

"yank to sys sel1
nnoremap <leader>s "*y
vnoremap <leader>s "*y

"read sys clip
nnoremap <leader>p "+p
"read sys sel1
nnoremap <leader>is "*p

"insert formatted date cmd
nnoremap <leader>ia "=strftime(" %g/%m/%d/%H/%M/%S")<CR>P

nnoremap <leader>it "=strftime("%H:%M:%S")<CR>P

" Magit ldr
nnoremap <leader>M :Magit<CR>

" Insert Firefox Active Tab URL
nnoremap <leader>u :r !factab<CR>

"buffer nav
"buff next
nnoremap <c-n> :bn<CR>

"buff prev
nnoremap <c-p> :bp<CR>

"buf kill
nnoremap <c-k> :bd<CR>

"list buffers
nnoremap <leader>l :ls<CR>

set listchars=
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
    " | mulibyte
    set listchars=eol:¶,space:.,tab:\|·,trail:·,extends:»,precedes:«
else
    set listchars=eol:$
endif


"reload .vimrc 
nnoremap <leader>r :source ~/.nvimrc<CR>:echo "reloaded ~/.nvimrc"<CR> 

"write
nnoremap <leader>w :w<CR>

"overwrite defaulte session "./sesh"
nnoremap <leader>s :mks! sesh<CR>

" muse 
nnoremap <leader>md :new <CR>:r !muse.do<CR>:set ft=vim<CR>gg

"make
nnoremap <leader>e :silent make build \| cw<CR>

" neomake
nnoremap <leader>n :Neomake<CR>

" path 
set path=.,/usr/include,~/ws,~/sputum,~/dot,~/Axiom,~/wiki


"tabs
se ts=4
set shiftwidth=0
set softtabstop=4
set expandtab
set smarttab "needs paste toggle to insert (>1) line excerpts 

" correct misspelled word to first available correction.
nnoremap <leader>z 1z=
" toggles
"spell
nnoremap <leader>vs :set spell!<CR>
nnoremap <leader>vh :set hlsearch!<CR>
nnoremap <leader>vl :set list!<CR>
nnoremap <leader>vr :set relativenumber!<CR>

" magit
nnoremap <leader>g :Magit<CR>

"pandoc latex to pdf
function! RenderMarkdown()
    let query = 'pandoc -fmarkdown+smart ' .  expand('%:r') . '.md -o ' . expand('%:r') . '.pdf --number-sections --pdf-engine=xelatex'
    echo system(query)
endfunction
nnoremap <leader>. :call RenderMarkdown()<CR>

"inoremap <c-l> <c-x><c-o>

function! DeadBuf()
    new | setlocal buftype=nofile | setlocal noswapfile 
endfunction

function! Define(word, ...)
    if a:0 > 0 " a:1 contains search strategy, see ```man dico``` or ```dico --help```
        let query = "dico -s " . a:1 . " -d* " . "'" . a:word . "'"
    else
        let query = "dico " . '-- "' . a:word . '"' . ' | fmt' 
    endif
    echo query
    " surmise
    let definitions = system(query) 
    if definitions == "dict (client_read_status): Error reading from socket\nclient_read_status: Success\n"
        "echo "error"
        let remote_query = "dict --host gnu.org.ua " . '"' . a:word . '"' . ' | fmt'
        let definitions = system(remote_query)
    endif
    silent call DeadBuf() | call bufname("dico") | silent put =definitions | normal ggdd 
    "call DeadBuf() | 
endfunction

" dict integration, Define keymap hook
com! -nargs=1 Def :call Define("<args>")
com! -nargs=* Defp :call Define("<args>", "prefix")
com! -nargs=* Defs :call Define("<args>", "suffix")
nnoremap <silent> <leader>d  :call Define(expand('<cword>'))<CR>


function! LsSyn(word)
    let sedFilter = " | sed 's/,/\\n/g' | sed 's/\\s//g' "
    let query = "dico -dmoby\-thesaurus " . "'" . a:word . "'" . sedFilter
    let synList = system(query)
    silent call DeadBuf() | call bufname("LsSyn") | silent put =synList | normal gg4dj
endfunction
" tighten
com! -nargs=1 LsSyn :call LsSyn("<args>")
nnoremap <silent> <leader>ls :call LsSyn(expand('<cword>'))<CR>

" trim whitespace in current buffer
function! TrimWhiteSpace()
    :%s/\s\+$//e
    return 0
endfunction

"detect gui; call apt tmux rename ...
function! TmuxRenameHuh()
    "if in terminal vim
    if (has('gui_running') == 0)
        "ren tmux window
        return 1
    else
        return 0
endfunction

" tmux (arbtt) title bar conf
" NOTE: vvv: assumes a SINGLE attatched tmux session at any given time
augroup title
    autocmd!     
    autocmd BufEnter,BufReadPost,FileReadPost,BufNewFile * if TmuxRenameHuh() | call system("tmux rename-window " . expand("%:t")) | endif
    autocmd VimLeave * if TmuxRenameHuh() | call system("tmux rename-window bash") | endif
augroup END

augroup mutt
    au!
    au FileType mail setlocal formatoptions+=aw
augroup END

set title

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whitespace = 'Ξ'

    let g:airline_section_b = '%{strftime("%m-%d [%H:%M]")}'
    let g:airline_section_y= 'BN: [%n] %r' 


"function
function! GitInfo()
    let git = fugitive#head()
    if git != ''
        return ' '.fugitive#head()
    else
        return ''
endfunction

se completeopt=menu ",preview

" lang specific auGrps
augroup haskell
    "clear pre-existing aucmd's
    autocmd! 
    "async lint ^ check
    "autocmd BufWritePost *.hs GhcModCheckAndLintAsync 
    "autocmd FileType haskell nnoremap <buffer> <leader>gt :GhcModType!<CR>
    "autocmd FileType haskell nnoremap <buffer> <leader>gl :GhcModLint!<CR>
    "autocmd FileType haskell nnoremap <buffer> <leader>gh :GhcModCheck!<CR>
    "autocmd FileType haskell nnoremap <buffer> <leader>gi :GhcModInfo!<CR>
    "autocmd FileType haskell nnoremap <buffer> <leader>gc :GhcModTypeClear!<CR>
    "autocmd FileType haskell nnoremap <buffer> <leader>gp :GhcModInfoPreview!<CR>
    "autocmd FileType haskell nnoremap <buffer> <leader>gca :GhcModSplitFunCase<CR>
    "autocmd FileType haskell nnoremap <buffer> <leader>gcg :GhcModSigCodegen<CR>

    "au FileType haskell lcd %:p:h
 

    " hindent
    "au FileType haskell setlocal formatprg=hindent
    "au FileType haskell compiler ghc
    "formatting, tw, shiftwidth

    "autocmd FileType haskell se tw=79
    "autocmd FileType haskell se shiftwidth=2
    "autocmd FileType haskell se softtabstop=2
    "autocmd FileType haskell se tabstop=2


    "direct hoogle integration (ghc-mod esque)
    "nnoremap <leader>h :HoogleInfo(expand('<cWORD>'), '-i')<CR>
    "nnoremap <leader>sh :HoogleInfo(expand('<cWORD>'), '-n 50')<CR>
    "au BufWritePost *.hs :Neomake! hdevtools

    "let g:ghcmod_ghc_options = ['-Wall', '-Wredundant-constraints', '-Wunused-binds', '-Wunused-imports', '-Wincomplete-record-updates', '-Wincomplete-uni-patterns', '-Wcompat']

    "function! HoogleDoc(searchTerms)
    "   let query = "stack hoogle -- -i  \'" . a:searchTerms . "\'"  
    "    let info = system(query)
    "    let resize = "resize " . (winheight(0) * 1/4) 
    "    call DeadBuf() | exe resize | call bufname("HoogleDoc") | setlocal ft=haskell | put =info
    "endfunction

    "au FileType haskell nnoremap <buffer> K :call HoogleDoc(expand('<cWORD>'))<CR>

    " haskell-vim settings

    "let g:haskell_enable_quantification = 1
    "let g:haskell_enable_recursive_do = 1
    "let g:haskell_enable_arrowsyntax = 1
    "let g:haskell_enable_pattern_synonyms = 1
    "let g:haskell_enable_typeroles = 1
    "let g:haskell_enable_static_pointers = 1
    "let g:haskell_backpack = 1

    " neco-ghc
    "let g:necoghc_use_stack = 1 
    "let g:necoghc_enable_detailed_browse = 1

augroup END
  
" rust-lang/rust.vim
augroup rust
    autocmd!
    autocmd FileType rust compiler! cargo
    "autocmd FileType rust nnoremap <leader>e :Neomake cargo \| ll<CR> 
    autocmd FileType rust setl makeprg=cargo
    autocmd FileType rust setl tw=79
    autocmd FileType rust nmap gd <Plug>(rust-def)
    autocmd FileType rust nmap <leader>ds <Plug>(rust-def-split)
    autocmd FileType rust nmap <leader>dv <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <leader>do <Plug>(rust-doc)

    autocmd FileType rust :setlocal tags=./rusty-tags.vi;/
    autocmd FileType rust :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
    au FileType rust nnoremap <leader>f :!cargo +nightly fmt<CR>

    au FileType rust nmap <leader>de :call RustExplainErr()<CR>
    au BufWritePost *.rs :silent Neomake! cargo \| ll<CR>
    au FileType rust nnoremap <leader>f :call CargoFmt()<CR>

    let g:neomake_rust_enabled_makers = ['cargo']
    let g:neomake_open_list=0
    let g:neomake_verbose=1

    " rust: racer
    let g:racer_cmd = "/home/aporia/.cargo/bin/racer"
    let g:racer_experimental_completer = 0

    " rust get error explanation
    function! RustExplainErr()
        let get_err_query = 'rust_err_at_line ' . line('.')
        let err_num = system(get_err_query)
        let explaind_q = 'cargo --explain ' . err_num
        let err_explained = system(explaind_q)
        call DeadBuf() | call bufname("explained") | setlocal ft=rust | put =err_explained
    endfunction
    " check tests
    let g:neomake_rust_cargo_command = ['check', '--tests']
augroup END


" markdown
augroup Markdown
    autocmd!
    autocmd FileType markdown nnoremap <leader>m :silent !pan % &<CR>
augroup END

set tags=tags;/tags;,codex.tags;/
set tags+=ctags;/

" airline
"let g:airline_powerline_fonts = 1
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
call deoplete#custom#source('_', 'max_menu_width', 90)
call deoplete#custom#source('_', 'mark', '')
call deoplete#custom#option('smart_case', v:true)

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:deoplete#max_menu_width = 110

"deoplet rust
let g:deoplete#sources#rust#racer_binary='/home/aporia/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/aporia/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

"let g:LanguageClient_serverCommands = {
"    \ 'haskell': ['hie', '--lsp'],
"    \ }

" 'rust': ['rustup', 'run', 'stable', 'rls'],
augroup coq
    au!
    au FileType coq se ts=2
augroup END
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
""nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


"personal log conf
au BufEnter ~/sputum/muse/* nnoremap <buffer> <leader>v o<Esc>16i <Esc>a--- vs ---<Esc>o
au BufEnter ~/sputum/muse/* setfiletype muse
au BufEnter ~/sputum/muse/* set efm=%EFile:\ %f,%+C>\ (interactive):l:%c:%m,%+Z>\ %.%#,%+C>\ %.%#
" log w style
nnoremap <leader>t Go<C-r>=strftime("%H:%M:%S λ. ")<CR>

" checkbox
" <leader>b : insert '□  ' | replace w ▣
function! CheckBox() 
    let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if char == "□"
        echo "matched!"
        execute "normal r▣"
    elseif char == "▣"
        execute "normal r□"
    else
        echo "inserted checkbox"
        execute "normal i□  "
    endif
endfunction
nnoremap <leader>b :call CheckBox()<CR>

"c lang conf
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-4.0/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
augroup C 
    au!
    au BufWritePost *.c :Neomake
augroup END

" rainbow
"let g:rainbow_active = 1

au! VimEnter * AirlineRefresh
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

"use one of
colo base16-gruvbox-dark-hard
"colo base16-gruvbox-dark-pale
"colo base16-bright
