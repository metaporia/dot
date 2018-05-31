#login shell conf (sourced: /etc/profile bash_prof,  .bash_login .prof ... bash_logout)

#/etc/profile loads /etc/profile.d/*.sh; trivial additions 

EDITOR=/usr/bin/vim
VISUAL=''  
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
PATH=/home/aporia/.conda3/bin:$HOME/.cargo/bin:/home/aporia/neovim/bin:/home/aporia/.local/bin:/home/aporia/ws/bin:/home/aporia/ws/bin/helpers:/usr/lib/x86_64-linux-gnu/bin/:/home/aporia/.config/base16-shell/scripts/:/usr/sbin/:/sbin/:$PATH
 
LESS="-R"
VIMRUNTIME=/usr/share/vim/vim80

PAGER='less -R'
HACKDIR=/home/aporia/games/nethack
NETHACKDIR=/home/aporia/games/nethack

RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
CARGO_HOME=$HOME/.cargo/
TIMEFORMAT=$'\e[0;30m\e[47mreal:%Rs user:%Us sys:%Ss cpu:%P%%\e[0m'


HISTTIMEFORMAT=$"%g/%m/%d /%H:%M:%S "
HISTFILE=~/.bash_hist_inf
HISTCONTROL='ignoreboth'

HISTSIZE=-1
HISTFILESIZE=-1

source ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"
