#aliases 


#ls 
alias ll='ls -alF'
alias la='ls -lAh'
alias l='ls -CF'
alias cl='clear;ls'
alias cla='clear;ls -lAh'
alias lt='ls -t'

#git 

##satus
alias gs='git status -s' # -s : sparse output
alias gsl='git status' # -l : default or long output
alias gsv='git status -v' # -v : verbose output

##add
alias gau='git add -u' # -u : stages modified, deleted; not new 
alias gaa='git add -A' # stages ALL
alias ga='git add' # stages ALL

##commit
alias gcn='git commit' # 'n' : pnemonic for 'NO -m flag'
alias gc='git commit -m' # expects $1: <commit msg> 
alias gctt='git commit -m "tiny tweaks"'  # default commit msg  

##branch
alias gb='git branch -v'
alias gbd='git branch -vd'

#remote
alias gr='git remote -v'


#vim, gvim
alias g='gvim'
alias v='vim'

#filesystem nav.
alias ..='cd ..'
alias cb='cd -'

