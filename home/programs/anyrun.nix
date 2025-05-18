{ pkgs, inputs, ... }: {
  # TODO:
  # - add nixos-option search; see https://github.com/n3oney/anyrun-nixos-options
  # imports = [ inputs.anyrun.homeManagerModules.default ];
  home.packages = with pkgs; [ kidex ];

  systemd.user.services = {
    kidex = {
      Unit = { Description = "Kidex file indexer"; };
      Service = { ExecStart = "${pkgs.kidex}/bin/kidex"; };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };

  xdg.configFile."kidex.ron".text = ''
    Config(
      ignored: [ ".git", ".*" ],
      //max_entries: 3,
      directories : [
        WatchDir(
          path: "/home/aporia",
          recurse: true,
          ignored: [ "src", "build", "Games" ],
        ),
      ],

    )
  '';

  programs.anyrun = {
    enable = true;
    config = {
      # enable plugins via flake output or here?
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        # plugin order determines result ordering in picker
        applications
        shell
        stdin
        translate
        websearch
        dictionary
        kidex
        symbols
      ];
      width = { fraction = 0.5; };
      x = { fraction = 0.5; };
      y = { fraction = 0.5; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = null;
    };

    extraConfigFiles = {

      "kidex.ron".text = ''
        // <Anyrun config dir>/kidex.ron
        Config(
          //prefix: ":",
          max_entries: 6,
        )
      '';

      "translate.ron".text = ''
        // <Anyrun config dir>/translate.ron
        Config(
          prefix: ":",
          language_delimiter: ">",
          max_entries: 3,
        )
      '';

      "shell.ron".text = ''
        // <Anyrun config dir>/shell.ron
        Config(
          prefix: "!",
          // Override the shell used to launch the command
          shell: bash,
        )
      '';

      "symbols.ron".text = ''
        // <Anyrun config dir>/symbols.ron
        Config(
          // The prefix that the search needs to begin with to yield symbol results
          prefix: "",
          // Custom user defined symbols to be included along the unicode symbols
          symbols: {
            // "name": "text to be copied"
            "shrug": "¯\\_(ツ)_/¯",
          },
          max_entries: 3,
        )
      '';

      "websearch.ron".text = ''
        Config(
          prefix: "?",
          // Options: Google, Ecosia, Bing, DuckDuckGo, Custom
          //
          // Custom engines can be defined as such:
          // Custom(:
          //   name: "Searx",
          //   url: "searx.be/?q={}",
          // )
          //
          // NOTE: `{}` is replaced by the search query and `https://` is 
          // automatically added in front.
          engines: [Google] 
        )
      '';
    };

    extraCss = ''
      @define-color bg-col  rgba(30, 30, 46, 0.7);
      @define-color bg-col-light rgba(150, 220, 235, 0.7);
      @define-color border-col rgba(30, 30, 46, 0.7);
      @define-color selected-col rgba(150, 205, 251, 0.7);
      @define-color fg-col #D9E0EE;
      @define-color fg-col2 #F28FAD;

      * {
        transition: 200ms ease;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 1.3rem;
      }

      #window {
        background: transparent;
      }

      #plugin,
      #main {
        border: 3px solid @border-col;
        color: @fg-col;
        background-color: @bg-col;
      }
      /* anyrun's input window - Text */
      #entry {
        color: @fg-col;
        background-color: @bg-col;
      }

      /* anyrun's ouput matches entries - Base */
      #match {
        color: @fg-col;
        background: @bg-col;
      }

      /* anyrun's selected entry - Red */
      #match:selected {
        color: @fg-col2;
        background: @selected-col;
      }

      #match {
        padding: 3px;
        border-radius: 6px;
      }

      #entry, #plugin:hover {
        border-radius: 6px;
      }

      box#main {
        background: rgba(30, 30, 46, 0.7);
        border: 1px solid @border-col;
        border-radius: 5px;
        padding: 5px;
      }
    '';
  };
}
