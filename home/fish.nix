{
  programs.fish = {
    enable = true;
    shellInit = ''
      bind \ea 'history-token-search-backward'
      bind \cs 'prepend_command sudo'
      #fish_add_path /home/aporia/scripts/
      set fish_greeting

      # colorize manpages
      set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
      set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
      set -x LESS_TERMCAP_me \e'[0m'           # end mode
      set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
      set -x LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
      set -x LESS_TERMCAP_ue \e'[0m'           # end underline
      set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
    '';

    functions = {
      prepend_command = ''
        et -l prepend $argv[1]
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
      '';

    };
    shellAbbrs = {
      cb = "cd -";
      g = "git";
      gs = "git status --short";
      gaa = "git add --all";
      ga = "git add";
      gau = "git add -u"; # stage modified, deleted, not new.;
      gcm = "git commit -m";
      gctt = "git commit -m 'Tiny tweaks.'";
      gp = "git p";
      gb = "git branch --all";
      gr = "git remote --verbose";
      gl = "git log --graph --oneline --decorate";
      gls = "git log --graph --oneline --decorate --stat";
      gd = "git diff";
      gdc = "git diff --cached";
      gca = "git commit --amend --no-edit";
      gg = "git pull";
      ta = "tmux attach -t";
      t = "tmux new -A -s"; # attach or create <sesh>
      tks = "tmux kill-session -t";
      ts = "tmux list-sessions";
      tp = "tmux list-panes";
      tw = "tmux list-windows";
      ti = "tmux info";
      vi = "nvim";
      vis = "vi -S sesh";
      magit = "nvim +MagitOnly";
      gc = "gcide -ne";
      m = "muse -c search ";
      mp = "muse parse";
      mu = "mupdf";
      open = "xdg-open";
    };
  };

}
