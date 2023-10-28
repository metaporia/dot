set fish_greeting ""

# PATH
#set -gx PATH /home/aporia/.cargo/bin \
#             /home/aporia/.local/bin \
#             /home/aporia/.config/base16-shell/scripts \
#             /bin \
#             /sbin \
#             /usr/sbin \
#             /home/aporia/scripts \
#             /usr/bin \
#             /usr/local/bin \
#             /home/aporia/.stack/programs/x86_64-linux/ghc-tinfo6-8.6.5/bin \
#             /home/aporia/.nvm/versions/node/v11.12.0/bin \
#             /home/aporia/.nix-profile/bin/
#
#            #/opt/anaconda/bin/
#            #/home/aporia/.stack/programs/x86_64-linux/ghcjs-0.2.0.9006020_ghc-7.10.3/bin
#            #/home/aporia/.conda3/bin \
#            #/home/aporia/neovim/bin \
#            #/home/aporia/Downloads/node-v8.11.2-linux-x64/bin \
#            #/home/aporia/src/binaryen/bin

# cabal-helpel for ghc-mod on ghc 8.0.2
#switch (hostname)
#case hub
#  set -gx cabal_helper_libexecdir /home/aporia/muse/.stack-work/install/x86_64-linux/lts-9.21/8.0.2/libexec/x86_64-linux-ghc-8.0.2/cabal-helper-0.7.3.0
#case '*'
#    set -gx cabal_helper_libexecdir /home/aporia/.stack/snapshots/x86_64-linux-tinfo6/lts-9.21/8.0.2/libexec/x86_64-linux-ghc-8.0.2/cabal-helper-0.7.3.0/
#end


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
abbr -a cb 'cd -'
abbr -a g 'git'
abbr -a gs 'git status --short'
abbr -a gaa 'git add --all'
abbr -a ga 'git add'
abbr -a gau 'git add -u' # stage modified, deleted, not new.
abbr -a gcm 'git commit -m'
abbr -a gctt 'git commit -m \'Tiny tweaks.\''
abbr -a gp 'git p'
abbr -a gb 'git branch --all'
abbr -a gr 'git remote --verbose'
abbr -a gl 'git log --graph --oneline --decorate'
abbr -a gls 'git log --graph --oneline --decorate --stat'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr gca 'git commit --amend --no-edit'
abbr gg 'git pull'

# tmux
abbr -a ta 'tmux attach -t'
abbr -a t 'tmux new -A -s' # attach or create <sesh>
abbr -a tks 'tmux kill-session -t'
abbr -a ts 'tmux list-sessions'
abbr -a tp 'tmux list-panes'
abbr -a tw 'tmux list-windows'
abbr -a ti 'tmux info'

# nvim
abbr -a vi nvim
abbr -a vis 'vi -S sesh'
abbr magit 'nvim +MagitOnly'

# gcide
abbr -a gc 'gcide -ne'

# muse
abbr m 'muse -c search '
abbr mp 'muse parse'
abbr -a -- log 'nvim -cLogToday -- ~/sputum/muse/{*,(today)}'


# misc
abbr -a mu 'mupdf'
alias open 'xdg-open'


################
# Key-mappings #
################

bind \ea 'history-token-search-backward'
bind \cs 'prepend_command sudo'



#############
# Functions #
#############

function prepend_command
    set -l prepend $argv[1]
    if test -z "$prepend"
        echo "prepend_command needs one argument"
        return 1
    end

    set -l cmd (commandline)
    if test -z "$cmd"
        commandline -r $history[1]
    end

    set -l old_cursor (commandline -C)
    commandline -C 0
    commandline -i "$prepend "
    commandline -C (math $old_cursor + (echo $prepend | wc -c))
end





#########
# Cruft #
#########

# cheat () { curl -s "http://cheat.sh/$1" ; }
#
#

#thefuck --alias | source

# OPAM configuration
# . /home/aporia/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

# base16-flat.sh
base16-irblack.sh

# ghcup-env
#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
#test -f /home/aporia/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /home/aporia/.ghcup/bin $PATH

bass source ~/.nix-profile/etc/profile.d/nix.sh
