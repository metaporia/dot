" vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neomake/neomake'
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
Plug 'junegunn/goyo.vim'
Plug 'chriskempson/base16-vim'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'} 
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell' }
Plug 'eagletmt/neco-ghc', {'for': 'haskell' }
Plug 'alx741/ghc.vim', {'for': 'haskell' }
Plug 'Twinside/vim-hoogle', {'for': 'haskell' }
Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-surround'
Plug 'jreybert/vimagit'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  
Plug 'tpope/vim-fugitive'
Plug 'zchee/deoplete-clang', {'for': 'c'}
"Plug 'luochen1990/rainbow'
"Plug 'christoomey/vim-tmux-navigator'
autocmd! User goyo.vim echom 'Goyo is now loaded!'
call plug#end()

inoremap jk <ESC>
vnoremap jk <ESC>

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
se timeoutlen=500
" keycode timeout
se ttimeoutlen=200

se tw=79

se breakindent

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

"COLORs n aesthetic bullcrap upon which I fixate

"if filereadable(expand("~/.vimrc_background"))
"    let base16colorspace=256
"    source ~/.vimrc_background
"endif
if has("termguicolors")
    set termguicolors
endif
colo base16-google-light

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

"yank to sys sel1
nnoremap <leader>s "*y

"read sys clip
nnoremap <leader>p "+p
"read sys sel1
nnoremap <leader>is "*p

"insert formatted date cmd
nnoremap <leader>ia "=strftime(" %g/%m/%d/%H/%M/%S")<CR>P

nnoremap <leader>it "=strftime("%H:%M:%S")<CR>P

" log w style
nnoremap <leader>t Go<C-r>=strftime("%H:%M:%S λ. ")<CR>

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

" muse 
nnoremap <leader>md :new <CR>:r !muse.do<CR>:set ft=vim<CR>gg

"make
nnoremap <leader>e :silent make build \| cw<CR>

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

"inoremap <c-l> <c-x><c-o>

function! DeadBuf()
    new | setlocal buftype=nofile | setlocal noswapfile 
endfunction

function! Define(word)
    let query = "dict " . '"' . a:word . '"' . ' | fmt'
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
com! -nargs=* Def :call Define("<args>")
nnoremap <silent> <leader>d  :call Define(expand('<cword>'))<CR>


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
        autocmd BufEnter,BufReadPost,FileReadPost,BufNewFile * if TmuxRenameHuh() | call system("tmux rename-window vim" . expand("%:p")) | endif
        autocmd VimLeave * if TmuxRenameHuh() | call system("tmux rename-window bash") | endif
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
            autocmd FileType haskell nnoremap <buffer> <leader>gt :GhcModType<CR>
            autocmd FileType haskell nnoremap <buffer> <leader>gl :GhcModLint<CR>
            autocmd FileType haskell nnoremap <buffer> <leader>gh :GhcModCheck<CR>
            autocmd FileType haskell nnoremap <buffer> <leader>gi :GhcModInfo<CR>
            autocmd FileType haskell nnoremap <buffer> <leader>gc :GhcModTypeClear<CR>
            autocmd FileType haskell nnoremap <buffer> <leader>gp :GhcModInfoPreview<CR>
            autocmd FileType haskell nnoremap <buffer> <leader>gca :GhcModSplitFunCase<CR>
            autocmd FileType haskell nnoremap <buffer> <leader>gcg :GhcModSigCodegen<CR>

            au FileType haskell compiler ghc
            au FileType haskell set kp=hoogle
            "formatting, tw, shiftwidth
            autocmd FileType haskell se tw=79
            autocmd FileType haskell se shiftwidth=4
            autocmd FileType haskell se sts=4

            "direct hoogle integration (ghc-mod esque)
            "nnoremap <leader>h :HoogleInfo(expand('<cWORD>'), '-i')<CR>
            "nnoremap <leader>sh :HoogleInfo(expand('<cWORD>'), '-n 50')<CR>
            au FileType haskell nnoremap <buffer> K :exec 'HoogleInfo' expand('<cWORD>')<CR>
            au BufWritePost *.hs :Neomake
    
    "function! HoogleInfo(searchTerms, flag)
    "    let query = "stack exec hoogle -- " . a:flag .  " \'" . a:searchTerms . "\'"  
    "    let info = system(query)
    "    echo info
    "    return ''
    "endfunction
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

    au FileType rust nmap <leader>de :call RustExplainErr()<CR>
    au BufWritePost *.rs :silent Neomake! cargo \| ll<CR>

augroup END

" rust get error explanation
function! RustExplainErr()
    let get_err_query = 'rust_err_at_line ' . line('.')
    let err_num = system(get_err_query)
    let explaind_q = 'cargo --explain ' . err_num
    let err_explained = system(explaind_q)
    call DeadBuf() | call bufname("explained") | setlocal ft=rust | put =err_explained
endfunction

let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_open_list=0
let g:neomake_verbose=1

" rust: racer
let g:racer_cmd = "/home/aporia/.cargo/bin/racer"
"let g:racer_experimental_completer = 1

" markdown
augroup Markdown
    autocmd!
    autocmd FileType markdown nnoremap <leader>m :silent !pan % &<CR>
augroup END

" airline
"let g:airline_powerline_fonts = 1
let g:deoplete#enable_at_startup = 1

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
colo base16-google-light
