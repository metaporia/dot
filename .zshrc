# If you come from bash you might have to change your $PATH.
 export PATH=/usr/bin/vim:.:$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
 export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
#other theme dimensions

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, ubuntu, vim)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='vim'
# fi

#emacs daemopn alias
alias spak='emacsclient -t'
alias gspak='emacsclient -c' # throws error without $emacs --daemon 

alias cls='clear'

alias pop='~/popcorn/Popcorn-Time'

#git aliases
alias gdl='git add --all'
alias gcm='git commit -m' 
alias gus='git status'
alias diff='git difftool -yt vimdiff'
alias dif='git difftool -yt meld'


#conf aliases
alias dotz='${EDITOR:-vi} ~/.zshrc' #zsh conf
alias dotv='${EDITOR:-vi} ~/.vimrc' #vim conf
alias dott='${EDITOR:-vi} ~/.tmux.conf' #tmux conf
alias dots='${EDITOR:-vi} ~/.spacemacs' #spacemacs conf

#source aliases
alias soz='source ~/.zshrc'

#misc aliases
alias ftw='echo FUCK THE WORLD'

#tmux 
alias tsesh='tmux new -s' #call >> tsesh <session_name>

alias ok='okular'
alias cla='clear;la'
alias cl='clear;ls'
alias cll='clear;ls -l'
alias lt='ls -lt'
alias clt='clear;ls -lt'


#vless; **depends on nvim fs
alias les="/usr/bin/vim -c 'set ft=man' -"
#export MANPAGER="/usr/bin/vim -c 'set ft=man' -"
#export PAGER="/usr/bin/vim -c 'set paste | set ft=man' - "

#axiom/wiki 
alias viki="nvim -u ~/wiki/.vimrc_wiki"

#editor
alias v='/usr/bin/vim'

alias ash='/home/aphoria/alacritty/target/release/alacritty'
export EDITOR='/usr/bin/vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#vi mode
bindkey -v
bindkey jk vi-cmd-mode
bindkey kj vi-cmd-mode
bindkey '^r' history-incremental-search-backward
bindkey '^u' backward-kill-line
bindkey '^w' backward-kill-word
bindkey '^h' backward-delete-char
bindkey '^h' backward-delete-char
#export KEYTIMEOUT=1



#
#

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"

#redd: less config
alias re="less -k/home/aphoria/redd.less"
#reload ~/redd.lesskey
alias sore="lesskey -o ~/redd.less ~/redd.lesskey" #poss. mv to ~/redd/{.less, .lesskey}

#set env vars
export LESS="-R -i -M -W"

