" keane. in reponse to gvim + vim screen flicker. not tmux. vim -U NONE
" resolves. color issue w vim ^/v tmux, gnome-terminal

"MINIMUM CONFIG
"     - setttings
"     - no bindings
"     - mostly platform agnostic (no color, term, etc..)


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

"don't arbitrarily go to start of new line. yes!! 
set nostartofline

"display cursor position
set ruler

"show status line: always
set laststatus=2

set cursorline


" Instead of failing a command because of unsaved changes, instead raise a
" " dialogue asking if you wish to save changed files.
set confirm

set novisualbell

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
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab "needs paste toggle to insert (>1) line excerpts 


"breakindent obeys smarttab indentation (I believe)

set breakindent 


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
inoremap kj <ESC>
vnoremap jk <ESC>
vnoremap kj <ESC>

"leader
let mapleader="\<Space>"



"toggles

"spell
nnoremap <leader>vs :set spell!

"paste 
set pastetoggle=<F3>

"numbering
nnoremap <leader>vr :set relativenumber!<CR>
nnoremap <leader>vn :set number!<CR>

"search
nnoremap <leader>vh :set hlsearch!<CR>

"reload .vimrc 
nnoremap <leader>r :source ~/.vimrc<CR>:echo "reloaded ~.vimrc"<CR> 

"write
nnoremap <leader>w :w<CR>

"edit! ie reload file. discard changes
nnoremap <leader>e :e!<CR>

"meta data entry 

"insert formatted date cmd
nnoremap <leader>da "=strftime(" %g/%m/%d/%H/%M/%S")<CR>P
nnoremap <leader>dt "=strftime("%H:%M:%S")<CR>P

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
nnoremap <leader>ic <F3>:r !xclip -selection clipboard -o<CR><F3> 
"read sys sel1
nnoremap <leader>is <F3>:r !xclip -selection clipboard -o<CR><F3> 

"COLORs n aesthetic bullcrap upon which I fixate
set bg=dark "inform vim of bg color
colo solarized


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
augroup END
