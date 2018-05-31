#aliases 
alias vi=nvim
alias vis='vi -S sesh'

#ls 
alias ll='ls -alF'
alias la='ls -lAh'
alias l='ls --color=always'
alias cl='clear;ls'
alias cla='clear;ls -lAh'
alias lt='l -t'


#tree
#alias tre='tree -C | less'
alias tra='tree -aCDt | less'

#git 

##errata 
alias gcl="git clone"

alias gl='git log --graph --oneline --decorate'

alias gt='git tag'

##status
alias gss='git status -s' # -s : sparse output
alias gs='git status' # -l : default or long output
alias gsv='git status -v' # -v : verbose output

##add
alias gau='git add -u' # -u : stages modified, deleted; not new 
alias gaa='git add -A' # stages ALL
alias ga='git add' # stages ALL

##commit
alias gc='git commit' # 'n' : pnemonic for 'NO -m flag'
alias gcm='git commit -m' # expects $1: <commit msg> 
alias gctt='git commit -m "tiny tweaks"'  # default commit msg  

##diff
alias gd='git diff'

##push
alias gp='git push'

##pull
alias gpl='git pull'

##branch
alias gb='git branch -av'
alias gbd='git branch -vd'

#remote
alias gr='git remote -v'

#vim, gvim
alias vg='vim -g'
alias v='vim'

##remote 
alias vgs="gvim --servername GVIM"
alias vs="vim --servername VIM"

#filesystem nav.
alias ..='cd ..'
alias cb='cd -'



#tmux
alias tmux='tmux -2' # run in 256color mode 
alias ta="tmux -2 attach -t" # attatch to <session>
alias tn="tmux new -s" #session name here 
alias t="tmux new -A -s"

##list-*
alias tp="tmux list-panes"
alias tw="tmux list-windows"
alias ts="tmux list-sessions"
alias ti="tmux info"

##kill-*
alias tks="tmux kill-session -t"
alias tkw="tmux kill-window -t"
alias tkp="tmux kill-pane -t"


#firefox
alias fire='~/bin/raise_Fire&'
alias ok='~/bin/raise_Okular&'
alias rag='~/bin/raise_GVIM'

 
#nethack
alias net='nethack -dec'

#mimeopen
alias o='mimeopen'

#mupdf
alias mu='mupdf'

# make
alias ma='make all'
alias mb='make build'

# conda env [de]activation
alias sa='source activate'
alias sd='source deactivate'

alias cc='xclip -sel clip'
alias cs='xclip -sel secondary'
#--------------------#

# functions #

cheat () { curl -s "http://cheat.sh/$1" ; }

weather () { curl "http://wttr.in/$1" ; }




