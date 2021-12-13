setlocal tw=120
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal formatprg=clang-format

au BufWrite *.cc,*.c,*.cpp,*.h Neomake
