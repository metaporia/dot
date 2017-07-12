"
"keane. in reponse to gvim + vim screen flicker. not tmux. vim -U NONE
" resolves. color issue w vim ^/v tmux, gnome-terminal

"MINIMUM CONFIG
"     - setttings
"     - no bindings
"     - mostly platform agnostic (no color, term, etc..)
scriptencoding utf-8
set t_Co=256
"set t_ut=

"ditch vi
set nocompatible "remove for neovim

"backup; preclude .*.sw? clutter
se nobackup
se noswapfile
se nowritebackup

"unicode 
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
endif

" viminfo
" clear
set viminfo=
" mark history size
set viminfo+='2000,
" store (A-Z) -- global -- marks
set viminfo+=f1,
"lines saved per register, per file
set viminfo+=<500,
" lines saved from cmdline hist
set viminfo+=:1000,
" lines <- input line hist (@)
set viminfo+=@500,
"lines <- search hist
set viminfo+=/500,
set viminfo+=n/home/aporia/.viminfo


"sessions


"sanify backspace
set backspace=indent,eol,start

"file type detection; per lang indent scheme
filetype indent plugin on

"enable syntax highlighting
syntax on

"switch buffers w/o save
set hidden

"cmdline completion
set wildmenu

"partial command string displayed in bottom right corner
set showcmd

"highlight search results
set nohlsearch

set incsearch

"case insensitive search save explicit captilization
set ignorecase
set smartcase

"maintain current indentation if not overridden by filetype settings
set autoindent
set smartindent

"par, formatting
set formatprg=par

"don't arbitrarily go to start of new line. yes!! 
set nostartofline

"display cursor position
set ruler



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

"show git branch name
set statusline+=%{GitInfo()}
"[opt], display if_extant: Quickfix | Location, list 
set statusline+=\ %q\ 
" line #, (real: not screen column) column #
set statusline+=[%l]:[%2c]
" file position; %
set statusline+=\ [%p%%]

set cursorline


" Instead of failing a command because of unsaved changes, instead raise a
" " dialogue asking if you wish to save changed files.
set confirm

set novisualbell
se belloff=all

"enable mouse in modes: all
set mouse=a

set cmdheight=1

"history
"set history=300

set number
set relativenumber

"timeout: mappings ^ keycodes
set timeout 
"mapping timeout len: .5 sec
set timeoutlen=600 
"keycode timeout len
set ttimeoutlen=200

"tabs
se ts=4
set shiftwidth=0
set softtabstop=4
set expandtab
set smarttab "needs paste toggle to insert (>1) line excerpts 


"breakindent obeys smarttab indentation (I believe)

set breakindent 

set tw=79


"errata 
set showmatch "highligh paren match
set showmode 

set spelllang=en_us
set nospell

"pdf -> extractable text
command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - | fmt -csw78



"clipboard
set clipboard+=html
" MAPPINGS


"toggle paste mode 
"bindings

"Y : yy -> Y : y$ 
map Y y$


"ESC -> jk, kj; for modes: visual, normal, ex?
inoremap jk <ESC>
"inoremap kj <ESC>
vnoremap jk <ESC>
"vnoremap kj <ESC>

"leader
let mapleader="\<Space>"



"toggles

"spell
nnoremap <leader>vs :set spell!<CR>

"paste 
set pastetoggle=<F3>

"numbering
nnoremap <leader>vr :set relativenumber!<CR>
nnoremap <leader>vn :set number!<CR>
nnoremap <leader>vl :set list!<CR>

"list chars
set listchars=
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
    " | mulibyte
    set listchars=eol:¶,space:.,tab:\|·,trail:·,extends:»,precedes:«
else
    set listchars=eol:$
endif

"search
nnoremap <leader>vh :set hlsearch!<CR>

"reload .vimrc 
nnoremap <leader>r :source ~/.vimrc<CR>:echo "reloaded ~.vimrc"<CR> 

"write
nnoremap <leader>w :w<CR>

"edit! ie reload file. discard changes
"nnoremap <leader>e :e!<CR>

"meta data entry 

"insert formatted date cmd
nnoremap <leader>ia "=strftime(" %g/%m/%d/%H/%M/%S")<CR>P


nnoremap <leader>it "=strftime("%H:%M:%S")<CR>P

" log w style
nnoremap <leader>t Go<C-r>=strftime("%H:%M:%S λ. ")<CR>


"buffer nav

"buff next
nnoremap <c-n> :bn<CR>

"buff prev
nnoremap <c-p> :bp<CR>

"buf kill
nnoremap <c-k> :bd<CR>

"list buffers
nnoremap <leader>l :ls<CR>


"man.vim on
runtime! ftplugin/man.vim

"insert newline whilst in command mode 
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

"copy/paste

"sys clip
"append motion to yank
"yank to sys clip
nnoremap <leader>c "+y

"yank to sys sel1
nnoremap <leader>cs "*y

"read sys clip
nnoremap <leader>ic "+p
"read sys sel1
nnoremap <leader>is "*p



"COLORs n aesthetic bullcrap upon which I fixate
set bg=light "inform vim of bg color
let g:solarized_termcolors=256
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
"colo base16-google-light


" gui options. required pre .gvimrc sourcing 
set guioptions=acei
"a : autoselect text to sys sel
"c : confirm via console; no gui popups
"e : gui tabline 
"i : vim icon 

" muse 
nnoremap <leader>md :new <CR>:r !muse.do<CR>:set ft=vim<CR>gg


" path 
set path=.,/usr/include,~/ws,~/sputum,~/dot,~/Axiom,~/wiki
"$PATH 

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

    "formatting, tw, shiftwidth
    autocmd FileType haskell se tw=79
    autocmd FileType haskell se shiftwidth=4
    autocmd FileType haskell se sts=4

    "direct hoogle integration (ghc-mod esque)
    nnoremap <leader>h :echo HoogleInfo(expand('<cWORD>'), '-i')<CR>
    nnoremap <leader>sh :echo HoogleInfo(expand('<cWORD>'), '-n 50')<CR>
    
    function! HoogleInfo(searchTerms, flag)
        let query = "stack exec hoogle -- " . a:flag .  " \'" . a:searchTerms . "\'"  
        let info = system(query)
        echo info
        return ''
    endfunction
      
augroup END


"function
function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
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
   autocmd BufEnter,BufReadPost,FileReadPost,BufNewFile * if TmuxRenameHuh() | call system("tmux rename-window vim" . expand("%:p")) | endif
   autocmd VimLeave * if TmuxRenameHuh() | call system("tmux rename-window bash") | endif
augroup END
set title

augroup rust
    autocmd!
    autocmd FileType rust nnoremap <leader>rr :!cargo run<CR>
    "make 
    nnoremap <leader>e :silent make build \| cw \| redr!<CR>
    autocmd FileType rust compiler cargo
    autocmd FileType rust setl makeprg=cargo
    autocmd FileType rust setl tw=79 

augroup END

augroup lineWrap
        autocmd!
        autocmd FileType text,conf se wrap | se tw=79 
augroup END

function! DeadBuf()
    new | setlocal buftype=nofile | setlocal noswapfile 
endfunction

function! Define(word)
    let query = "dict " . '"' . a:word . '"'
    echo query
    let definitions = system(query) 
    silent call DeadBuf() | call bufname("dict") | silent put =definitions | normal ggdd 
    "call DeadBuf() | 
endfunction


" dict integration, Define keymap hook
com! -nargs=* Def :call Define("<args>")
nnoremap <silent> <leader>d  :call Define(expand('<cword>'))<CR>

"statically typed
