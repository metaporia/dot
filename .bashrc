# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


#alias tmux="env TERM=xterm-256color:Tc"



# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#-------------------------------------------------------------------------------
#additions 
## vi mode 

set -o vi
# echo "set editing-mode vi">~/.inputrc" //for all gnu readline calls 
#stty -ixon #forward searching.. verify


# load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi



# builtin time (1) fmt conf 
export TIMEFORMAT=$'\e[0;30m\e[47mreal:%Rs user:%Us sys:%Ss cpu:%P%%\e[0m'

#ETERNAL HISTORY !!!
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options

HISTTIMEFORMAT="[%g/%m/%d/%H:%M:%S]"
HISTFILE=~/.bash_hist_inf
HISTCONTROL=ignoreboth 

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1

set magic-space on 

set -o history

# shopt 
shopt -s histappend
shopt -s autocd 
shopt -s cdspell 
shopt -s globstar 
shopt -s nocasematch 
shopt -s nocaseglob
shopt -s checkwinsize

#todo;


#sourc <file> for config 
if [ -f ~/.bash_env ]; then
    . ~/.bash_env 
fi 

#prompt 

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
export EDITOR=/usr/bin/vim
export VISUAL='/usr/bin/vim -g'  

export PATH=/home/aporia/ws/bin:$PATH

