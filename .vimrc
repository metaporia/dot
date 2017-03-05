execute pathogen#infect()
set nocompatible
set exrc "vim will source .vimrc if in pwd

command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - | fmt -csw78

"unicode settings
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,latin1
endif

"nvim specific config
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog ='/usr/bin/python3'

"Nvim (notational velocity config)
let g:NVIM_database='~/notes/.nvim' " nvim totally broke

"ycm gcc config
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_always_populate_location_list = 1
let g:YcmErrorSign = '>>'
let g:YcmWarningSign = 'w>'

"colors
let g:solarized_termcolors=256
colorscheme solarized "PapayaWhip alternatively
set background=dark"light or dark

"rainbows
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16

let g:rbpt_loadcmd_toggle = 1
au VimEnter * RainbowParenthesesToggle 

"python settings
augroup grp1
    
    autocmd!
    autocmd Filetype python set syntax
    autocmd Filetype python syntax on
    autocmd Filetype python syntax enable
    autocmd Filetype python colorscheme solarized 
    autocmd Filetype python let python_highlight_all = 1
    autocmd FileType python set nowrap 
augroup END

"word processor mode 
func! WP() "call from vim cmd line w/ :Pword
    setlocal formatoptions=1
    setlocal spell 
    set formatprg=par
    setlocal wrap
    setlocal linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap gk k
    nnoremap gj j  
endfunction
"WP keymap
nnoremap <leader>wp :call WP()<CR>

"airline config
let g:airline_detect_iminsert=1
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"Powerline symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = '⭤'
let g:airline#extensions#ycm#enabled=1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'
"always on airline
set laststatus=2

"thesaurus 
"nnoremap <Leader>cs :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <Leader>cx y:ThesaurusQueryReplace <C-r>"<CR>

filetype plugin indent on
set relativenumber "line numbers
set showcmd
set cursorline

filetype indent on "loade file-type specific indent files (ex: ~/.vim/indent/python.vim)

set wildmenu "visual autocomplete

set lazyredraw "optimizes rendering efforts

set showmatch "highlight complementary parentheses

"searching
set incsearch " single character search buffer
set nohlsearch " highlights search values

"folding -- LEARN THIS
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

"movement by visual/screen line not '\n' delimitted line (i.e., real lines)
"nnoremap j gj
"nnoremap k gk
"nnoremap gk k
"nnoremap gj j  


"leader shortcuts
" <mapleader> = "\\"
let mapleader=" "

inoremap jk <Esc>
inoremap kj <Esc>
vnoremap kj <Esc>
vnoremap jk <Esc>

inoremap <C-[> <Esc>
nnoremap <F4> :NERDTreeToggle<CR>

nnoremap <leader>g :GundoToggle<CR>
nnoremap <leader>rr :source ~/.vimrc<CR>

syntax on
syntax enable " whats the diff between on and enable?
set breakindent " linebreaks observe indentation context
"set showbreak=\ \ 
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab "tab isnerts 'shiftwidth' spaces
set expandtab "tabs are spaces
"line wraping at col 79 would be great
set nospell
set showmode "shows current mode beneath powerline status bar
set autoindent
set ignorecase "case insensitive search
set smartcase "case sensitive on uppercase search phrase
set wrap
set spelllang=en_us
runtime ftplugin/man.vim
set hidden "allow undisplayed buffer persistence
set smartindent "? better i'd guess than stupid indent
set history=200

"insert newline whilst in command mode 
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
"whitespace chars
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>l :set list!<CR>

set pastetoggle=<F3>

"key rrmaps
"blocks gui while running
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR> 
 "deselects highlighted search results 
nnoremap <leader><C-l> :set nohlsearch!<CR>
nnoremap ; :
nnoremap : ;      

"add <up/down> prefix filter functionality their more convenient counterparts,
"c-n and c-p
cnoremap <c-p> <up>
cnoremap <c-n> <down>

"insert formatted date cmd
nnoremap <leader>da "=strftime("/%g/%m/%d/%H/%M/%S")<CR>P

"gui options
set guioptions="a"
