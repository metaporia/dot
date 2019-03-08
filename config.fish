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
           
# cabal-helpel for ghc-mod on ghc 8.0.2 
switch (hostname)
case hub
  set -gx cabal_helper_libexecdir /home/aporia/muse/.stack-work/install/x86_64-linux/lts-9.21/8.0.2/libexec/x86_64-linux-ghc-8.0.2/cabal-helper-0.7.3.0
case '*'
    set -gx cabal_helper_libexecdir /home/aporia/.stack/snapshots/x86_64-linux-tinfo6/lts-9.21/8.0.2/libexec/x86_64-linux-ghc-8.0.2/cabal-helper-0.7.3.0/
end

bass source /home/aporia/.nix-profile/etc/profile.d/nix.sh

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
abbr -a gs 'git status'
abbr -a gaa 'git add --all'
abbr -a ga 'git add'
abbr -a gau 'git add -u' # stage modified, deleted, not new.
abbr -a gcm 'git commit -m'
abbr -a gctt 'git commit -m \'Tiny tweaks.\''
abbr -a gp 'git push'
abbr -a gb 'git branch --all'
abbr -a gr 'git remote --verbose'
abbr -a gl 'git log --graph --oneline --decorate'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr gca 'git commit --amend --no-edit'

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


abbr -a mu 'mupdf'

alias open 'xdg-open'
abbr magit 'nvim +Magit -c"wincmd o"'

# cheat () { curl -s "http://cheat.sh/$1" ; }
#
#

#thefuck --alias | source

# OPAM configuration
# . /home/aporia/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
