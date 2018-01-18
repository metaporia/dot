let SessionLoad = 1
if &cp | set nocp | endif
nnoremap  :bd
nnoremap  :bn
nnoremap  :bp
nnoremap  dt "=strftime("%H:%M:%S")P
nnoremap  rr :!cargo run
nnoremap <silent>  d :call Define(expand('<cword>'))
nnoremap  da "=strftime(" %g/%m/%d/%H/%M/%S")P
nnoremap  e :make build | cw
nnoremap  sh :echo HoogleInfo(expand('<cWORD>'), '-n 50')
nnoremap  h :echo HoogleInfo(expand('<cWORD>'), '-i')
nnoremap  md :new :r !muse.do:set ft=vimgg
nnoremap  is "*p
nnoremap  ic "+p
nnoremap  cs "*y
nnoremap  c "+y
nnoremap  O O
nnoremap  o o
nnoremap  l :ls
nnoremap  t Go=strftime("%H:%M:%S λ. ")
nnoremap  it "=strftime("%H:%M:%S")P
nnoremap  ia "=strftime(" %g/%m/%d/%H/%M/%S")P
nnoremap  w :w
nnoremap  r :source ~/.vimrc:echo "reloaded ~.vimrc" 
nnoremap  vh :set hlsearch!
nnoremap  vl :set list!
nnoremap  vn :set number!
nnoremap  vr :set relativenumber!
nnoremap  vs :set spell!
map Y y$
let s:cpo_save=&cpo
set cpo&vim
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
vnoremap jk 
nnoremap <SNR>25_: :=v:count ? v:count : ''
nnoremap <SNR>26_: :=v:count ? v:count : ''
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
inoremap jk 
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=indent,eol,start
set belloff=all
set clipboard=autoselect,exclude:cons\\|linux,html
set confirm
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set formatprg=par
set guioptions=acei
set helplang=en
set hidden
set ignorecase
set iminsert=0
set incsearch
set laststatus=2
set listchars=eol:¶,space:.,tab:|·,trail:·,extends:»,precedes:«
set mouse=a
set pastetoggle=<F3>
set path=.,/usr/include,~/ws,~/sputum,~/dot,~/Axiom,~/wiki
set ruler
set runtimepath=~/.vim,~/.vim/pack/plugin/start/vimproc,~/.vim/pack/plugin/start/vim-fugitive,~/.vim/pack/plugin/start/ghcmod-vim,/usr/share/vim/vimfiles,/usr/share/vim/vim80,/usr/share/vim/vimfiles/after,~/.vim/after,~/.vim/pack/plugin/start/ghcmod-vim/after
set shiftwidth=0
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=4
set spelllang=en_us
set nostartofline
set statusline=%{strftime(\"%m-%d\ [%H:%M]\")}\ %F\ %y\ %r\ buf:[%n]%=%{GitInfo()}\ %q\ [%l]:[%2c]\ [%p%%]
set noswapfile
set tabstop=4
set termencoding=utf-8
set textwidth=79
set timeoutlen=600
set title
set ttimeoutlen=200
set viminfo='2000,f1,<500,:1000,@500,/500,n/home/aporia/dot/.viminfo
set wildmenu
set window=66
set nowritebackup
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/ws/lang/hs/hs/src
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +313 ~/.vimrc
badd +283 ch9.hs
badd +11 ~/sputum/muse/17.06.21
badd +5 ch10.hs
argglobal
silent! argdel *
$argadd ~/sputum/muse/17.06.21
edit ~/.vimrc
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
argglobal
vnoremap <buffer> <silent> [" :exe "normal! gv"|call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
nnoremap <buffer> <silent> [" :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
vnoremap <buffer> <silent> [] m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "bW")
nnoremap <buffer> <silent> [] m':call search('^\s*endf*\%[unction]\>', "bW")
vnoremap <buffer> <silent> [[ m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "bW")
nnoremap <buffer> <silent> [[ m':call search('^\s*fu\%[nction]\>', "bW")
vnoremap <buffer> <silent> ]" :exe "normal! gv"|call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
nnoremap <buffer> <silent> ]" :call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
vnoremap <buffer> <silent> ][ m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "W")
nnoremap <buffer> <silent> ][ m':call search('^\s*endf*\%[unction]\>', "W")
vnoremap <buffer> <silent> ]] m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "W")
nnoremap <buffer> <silent> ]] m':call search('^\s*fu\%[nction]\>', "W")
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
setlocal commentstring=\"%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'vim'
setlocal filetype=vim
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetVimIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=0
setlocal noshortname
setlocal signcolumn=auto
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
setlocal statusline=
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'vim'
setlocal syntax=vim
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal textwidth=79
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 379 - ((45 * winheight(0) + 33) / 67)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
379
normal! 02|
lcd ~/ws/lang/hs/hs/src
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
