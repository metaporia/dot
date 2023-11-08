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

{ config, inputs, pkgs, ... }:

{

  # Enable nix flakes
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';


  # use nixos nixpkgs for flake commands like 'nix shell nixpkgs#hello'
  nix.registry = { 
    nixpkgs.flake = inputs.nixpkgs;
    unstable.flake = inputs.nixpkgs;
  };


  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #<home-manager/nixos>
    # for some reason when both are imported
    ./wm/gnome.nix
    # ./wm/i3.nix
  ];

  # Allow installation of proprietary packages
  nixpkgs.config.allowUnfree = true;

  # use latest kernel for framework laptop wifi card support
  # see kvark/dotfiles on github for full (working) framework laptop config
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Use the GRUB 2 boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.

  networking.hostName = "kerfuffle"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  services.localtimed.enable = true;

  services.locate = {
  	enable = true;
	locate = pkgs.plocate;
	interval = "hourly";
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

  ## Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # forcefully kill X
    enableCtrlAltBackspace = true;

    # Enable touchpad see `man libinput` for more options
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        tapping = true;
      };
    };

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "ctrl:swapcaps";

    displayManager = {
      lightdm = {
        enable = true;
        greeter.enable = false;
      };
      autoLogin = {
        enable = true;
        user = "aporia";
      };
    };
  };

  # enable xkb keymap in console
  console.useXkbConfig = true;

  # enable sound server

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  environment.variables.EDITOR = "nvim";
  environment.localBinInPath = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    git
    tmux
    nix-doc
    nix-index
    gcc
    gnumake
    lutris
    wine
  ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.virtualbox.members = ["aporia"];

  #########
  # FONTS #
  #########

  fonts.fonts = with pkgs; [
  	(nerdfonts.override { fonts = [ "DroidSansMono" ]; })
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

  users.users.aporia = {
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/aporia";
    extraGroups = [ "wheel" "docker" "networkmanager" "plocate"];
    hashedPassword =
      "$6$hDmuVM9BSnuYhZOo$EfmduI43DDQ/ep0wgBK0iIxR4PXedpX8C2roy9rQtSvP4ZvBGw/lqMYlJWgNWRCl1aAwutbz2cSsgbddDguHV.";
    packages = with pkgs; [ git home-manager ];
  };

  # haskell.nix: enable binary cache
  # Binary Cache for Haskell.nix
  nix.binaryCachePublicKeys =
    [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
  nix.binaryCaches = [ "https://hydra.iohk.io" ];


}
