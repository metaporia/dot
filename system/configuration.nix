# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# Installation notes:
# - partition and mount drive(s)
# - clone ~/dot to somewhere in the root partition
# - run nix-generate-config
# - symlink dot/system to /etc/nixos but backup the hardware-configuration.nix
#   first--or at least check for discrepancies.
# - run nix-install

{ config, lib, inputs, pkgs, ... }:

{



  # FIXME nix-path
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = let path = toString ../.; in
      [
        "nixos-config=${path}"
        "repl=${path}/repl.nix"
        "nixpkgs-overlays=${path}/overlays"
      ] ++
      lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # pin system nixpkgs to that of the flake input



    settings = {
      # FIXME nix-path
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      builders-use-substitutes = true;

      # Binary Cache for Haskell.nix
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      ];


      substituters = [
        "https://cache.nixos.org"
        "https://cache.iog.io"
        "https://anyrun.cachix.org"
      ];
    };

  };


  # Enable nix flakes 
  # what does this do?
  nix.package = pkgs.nixVersions.latest;


  ################### 
  # Hyprland Config #
  ################### 

  security.polkit.enable = true;

  #systemd = {
  #  user.services.polkit-gnome-authentication-agent-1 = {
  #    description = "polkit-gnome-authentication-agent-1";
  #    wantedBy = [ "graphical-session.target" ];
  #    wants = [ "graphical-session.target" ];
  #    after = [ "graphical-session.target" ];
  #    serviceConfig = {
  #      Type = "simple";
  #      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #      Restart = "on-failure";
  #      RestartSec = 1;
  #      TimeoutStopSec = 10;
  #    };
  #  };
  #};

  # use nixos nixpkgs for flake commands like 'nix shell nixpkgs#hello'
  ##nix.registry = { 
  ##  nixpkgs.flake = inputs.nixpkgs;
  ##  unstable.flake = inputs.nixpkgs;
  ##};
  programs.hyprland.enable = true;
  system.nixos.tags = [ "hypr" ];
  # see https://github.com/erictossell/nixflakes/blob/main/modules/hyprland/greetd/default.nix
  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "aporia";
      };
      initial_session = {
        command = "Hyprland";
        user = "aporia";
      };
    };
  };

  # Enable touchpad see `man libinput` for more options
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      tapping = true;
    };
  };


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # forcefully kill X
    enableCtrlAltBackspace = true;

    # for hyprland, why the fuck does it need to be disabled?
    # it should default to false
    displayManager = {
      lightdm.enable = false;
    };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "dvorak";
      options = "ctrl:swapcaps";
    };
  };


  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #<home-manager/nixos>
    # for some reason when both are imported
    # ./wm/gnome.nix
    # ./wm/i3.nix
  ];

  # Allow installation of proprietary packages
  #nixpkgs.config.allowUnfree = true;

  # use latest kernel for framework laptop wifi card support
  # see kvark/dotfiles on github for full (working) framework laptop config
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Use the GRUB 2 boot loader.
  boot.loader = {
    # only keey last 10 generations
    systemd-boot.configurationLimit = 10;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.

  networking.hostName = "kerfuffle"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  services.automatic-timezoned.enable = true;

  # FIXME: automatic-timezoned is broken idk if this helps
  services.geoclue2.enableWifi = true;

  #services.dictd = {
  #  enable = true;
  #  DBs = with pkgs.dicts; with pkgs; [ pkgs.dictdDBs.wordnet gcide pkgs.dictdDBs.wiktionary jargon moby-thesaurus ];
  #};

  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "hourly";
    localuser = null;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  #networking.interfaces.wlan0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = { font = "Lat2-Terminus16"; };

  # TODO is this necessary?
  services.dbus.enable = true;

  # cpu temp fix
  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;

  # enable xkb keymap in console
  console.useXkbConfig = true;

  # enable sound server

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  # disable for non-alsa based setups
  # sound.enable = true; 
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # SSH
  services.openssh = {
    enable = true;
    #passwordAuthentication = false;
  };

  programs.ssh.startAgent = true;


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  environment.variables.EDITOR = "nvim";
  environment.localBinInPath = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Is it necessary to add package here? or will enabling it with the
    # home-manager module suffice?
    #inputs.anyrun.packages.${system}.anyrun-with-all-plugins 
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    git
    tmux
    nix-doc
    gcc
    gnumake
    lutris
    #wine
    kitty
  ];


  # Virtualisation

  # virtualbox
  #virtualisation.virtualbox.host = {
  #  enable = true;
  #  enableExtensionPack = true;
  #};
  #users.extraGroups.virtualbox.members = [ "aporia" ];

  # qemu/kvm
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;



  #########
  # FONTS #
  #########

  fonts.packages = with pkgs; [
    font-awesome # for waybar
    noto-fonts
    (nerdfonts.override { fonts = [ "DroidSansMono" "SourceCodePro" ]; })
  ];



  programs.dconf.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  # don't persist user state not declared in configuration.nix
  users.mutableUsers = false;
  programs.fish.enable = true;

  # test user to debug <nixpkgs> flake interaction
  users.users.test = {
    home = "/home/test";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "plocate" ];
    hashedPassword =
      "$6$hDmuVM9BSnuYhZOo$EfmduI43DDQ/ep0wgBK0iIxR4PXedpX8C2roy9rQtSvP4ZvBGw/lqMYlJWgNWRCl1aAwutbz2cSsgbddDguHV.";
    packages = with pkgs; [ git ];
  };

  users.users.aporia = {
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/aporia";
    extraGroups = [ "wheel" "docker" "networkmanager" "plocate" "libvirtd" ];
    hashedPassword =
      "$6$hDmuVM9BSnuYhZOo$EfmduI43DDQ/ep0wgBK0iIxR4PXedpX8C2roy9rQtSvP4ZvBGw/lqMYlJWgNWRCl1aAwutbz2cSsgbddDguHV.";
    packages = with pkgs; [ git home-manager ];
  };

}
