# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
. ~/src/z/z.sh
. ~/.fzf.bash
case $- in
    *i*) ;;
      *) return;;
esac
export VISUAL=nvim
export EDITOR="$VISUAL"

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



# If this is anase "$TERM" in
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

#ETERNAL HISTORY !!!
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

set magic-space on 


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

#prompt 17/05/08/12/05/21
case "$TERM" in
    xterm-color|*256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
#export PS1='${debian_chroot:+($debian_chroot)}\u@\h-\D{%g/%m/%d};\A\w\$ '

# haskell stack completion
eval "$(stack --bash-completion-script stack)"
#eval "$(pandoc --bash-completion)"

# `curl cheat.sh/$1`

#cheat.sh()
#{
#    # replace native with the color scheme you want
#    # curl cheat.sh/:styles-demo to show the available color schemes
#    curl -s cheat.sh/"$1"?style=native
#}
#
#_cheatsh_complete_cheatsh() 
#{
#    local cur opts #prev
#    _get_comp_words_by_ref -n : cur
#
#    COMPREPLY=()
#    prev="${COMP_WORDS[COMP_CWORD-1]}"
#    opts="$(curl -s cheat.sh/:list)"
#
#    #if [[ "${cur}" == ch ]] ; then
#		COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
#		__ltrim_colon_completions "$cur"
#        return 0
#    #fi  
#}
#
#complete -F _cheatsh_complete_cheatsh cheat.sh
#
#
#_cheatsh_complete_curl()
#{
#    local cur prev opts
#    _get_comp_words_by_ref -n : cur
#
#    COMPREPLY=()
#    #cur="${COMP_WORDS[COMP_CWORD]}"
#    prev="${COMP_WORDS[COMP_CWORD-1]}"
#    opts="$(curl -s cheat.sh/:list | sed s@^@cheat.sh/@)"
#
#    if [[ ${cur} == cheat.sh/* ]] ; then
#		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
#		__ltrim_colon_completions "$cur"
#        return 0
#    fi
#}
#
#complete -F _cheatsh_complete_curl curl

#base16-gruvbox-dark-hard.sh
xset r off
set -o history
