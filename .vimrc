execute pathogen#infect()

set exrc "vim will source .vimrc if in pwd
set secure " this may be hassle as it limits available commands


"ycm gcc config
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_always_populate_location_list = 1
let g:YcmErrorSign = '>>'
let g:YcmWarningSign = 'w>'

"colors
let g:solarized_termcolors=256
colorscheme solarized "PapayaWhip alternatively
set background=dark"light or dark


syntax enable 
filetype plugin indent on
set number "line numbers
set showcmd
set cursorline

filetype indent on "loade file-type specific indent files (ex: ~/.vim/indent/python.vim)

set wildmenu "visual autocomplete

set lazyredraw "optimizes rendering efforts

set showmatch "highlight complementary parentheses

"searching
set incsearch " single character search buffer
set hlsearch " highlights search values

"folding -- LEARN THIS
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

"movement by visual/screen line not '\n' delimitted line (i.e., real lines)
nnoremap j gj
nnoremap k gk

"leader shortcuts
" <mapleader> = "\\"

inoremap jj <esc> 
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <leader>rr :source ~/.vimrc<CR>

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab "tabs are spaces
"line wraping at col 79 would be great

"key rrmaps
"blocks gui while running
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR> 
 "deselects highlighted search results 
nnoremap <leader><C-l> :nohlsearch<CR>
