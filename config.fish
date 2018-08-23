set fish_greeting ""

# PATH
set -gx PATH /home/aporia/.cargo/bin \
             /home/aporia/.local/bin \
             /home/aporia/.config/base16-shell/scripts \
             /bin \
             /sbin \
             /usr/sbin \
             /home/aporia/scripts \
             /usr/bin \
             /usr/local/bin \
            #/home/aporia/.conda3/bin \
            #/home/aporia/neovim/bin \
            #/home/aporia/Downloads/node-v8.11.2-linux-x64/bin \
            #/home/aporia/src/binaryen/bin



#######################
#  coloring manpages  #
#######################

set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
set -x LESS_TERMCAP_me \e'[0m'           # end mode
set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -x LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
set -x LESS_TERMCAP_ue \e'[0m'           # end underline
set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline


##########
#   git  #
##########

#set __fish_git_prompt_showuntrackedfiles 'yes'
#set __fish_git_prompt_showdirtystate 'yes'
#set __fish_git_prompt_color_branch magenta
#set __fish_git_prompt_char_dirtystate '!'
#set __fish_git_prompt_char_untrackedfiles '?'
#set __fish_git_prompt_char_stagedstate '→'
#set __fish_git_prompt_char_stashstate '↩'
#set __fish_git_prompt_char_upstream_ahead '↑'
#set __fish_git_prompt_char_upstream_behind '↓'


#########
#  abbr #
#########

# git
abbr -a cb='cd -'
abbr gs='git status'
abbr gaa='git add --all'
abbr ga='git add'
abbr gau='git add -u' # stage modified, deleted, not new.
abbr gcm='git commit -m'
abbr gctt='git commit -m \'Tiny tweaks.\''
abbr gp='git push'
abbr gb='git branch --all'
abbr gr='git remote --verbose'
abbr gl='git log --graph --oneline --decorate'
abbr gd='git diff'

# tmux
abbr ta='tmux attach -t'
abbr t='tmux new -A -s' # attach or create <sesh>
abbr tks='tmux kill-session -t'
abbr ts='tmux list-sessions'
abbr tp='tmux list-panes'
abbr tw='tmux list-windows'
abbr ti='tmux info'

# nvim
abbr vi=nvim
abbr vis='vi -S sesh'


abbr mu='mupdf'

alias open='xdg-open'

# cheat () { curl -s "http://cheat.sh/$1" ; }
#
#

thefuck --alias | source
