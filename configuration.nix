# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs,inputs, ... }:


{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #  ./packages/crypto.com/default.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.initrd.availableKernelModules = [ "88x2bu"];
  boot.initrd.kernelModules = [ ];
  #boot.kernelModules = [ "mt7921u" ];
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
 networking.wireless.interfaces = [ "wlp0s29u1u6" ];
  # networking.interfaces.wlp0s29u1u6.useDHCP = true;
  networking.useDHCP = true;


  networking.wireless.networks = {
    ADAMO-26FC = {
      # SSID with no spaces or special characters
      pskRaw = "111442aa32462d6d50cf8222f2c4c114b960e6d1617826311dd16a90af96945b";
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
#  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "eno1" ];

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  services.blueman.enable = true;
  
  # Enable the XFCE Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;
#services.network-manager.enable = false;
  # Configure keymap in X11
  services.xserver = {
    xkb ={
      layout = "us,es";
    };
   # xkbvariant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  services.printing = {
  enable = true;
  drivers = [ pkgs.hplipWithPlugin ];
 };
  services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
};

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.pam.services.swaylock = { };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  virtualisation.docker.enable = false;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;
virtualisation.spiceUSBRedirection.enable = true;


  users.users.angel = {
    isNormalUser = true;
    description = "Angel";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];

    packages = with pkgs; [
      firefox
      google-chrome
      signal-desktop
      polkit_gnome
      gnome.file-roller
      tilix
      networkmanagerapplet
      slurp
      git
      libnotify
      libappindicator
      #  thunderbird
      brave
      ledger-live-desktop
      #rofi
      rofi-wayland
      kitty
      qt6Packages.qtstyleplugin-kvantum #kvantum
      libsForQt5.qtstyleplugin-kvantum #kvantum
      qt6.qtwayland
      wl-clipboard
      wlogout
      waybar
      swappy
      swayidle
      swaylock-effects
      swaynotificationcenter
      swww
      qt5ct
      qt6ct
      sublime3
      vlc
      xdg-utils
      xdg-desktop-portal-hyprland
      pywal
      fastfetch
      nixpkgs-fmt
      zsh-powerlevel10k
      whatsapp-for-linux
      telegram-desktop
      zathura
      imv
      numix-icon-theme-circle
      colloid-icon-theme
      catppuccin-gtk
      catppuccin-kvantum
      catppuccin-cursors.macchiatoTeal
      cliphist
      wl-clipboard
      nwg-look
      grim
      imagemagick
      gtk-engine-murrine
      wezterm
      libsForQt5.kdeconnect-kde
      yarn
  nodePackages.rush
  nodejs_18
  corepack_18
  # python311Packages.langchain
  # python311Packages.jupyter-core
  # python311Packages.pip
  # python311Packages.ipykernel
  #  python311Packages.jupyterlab
  #  python311Packages.nbformat
   python312Packages.pip
  python3
  poetry
  pyenv
  timeshift
  pyprland
    vimPlugins.LazyVim
    neovim
    killall
    libgccjit
    ripgrep
    hypridle
    hyprlock
vscode
warp-terminal
hplip
libreoffice
keepass
#zed-editor
    ];
  };
  users.defaultUserShell = pkgs.zsh;
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "angel";
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services = {
    udev.packages = with pkgs; [
      ledger-udev-rules

      # potentially even more if you need them
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #theme
  environment.variables.GTK_THEME = "Catppuccin-Macchiato-Standard-Teal-Dark";
  environment.variables.XCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  environment.variables.XCURSOR_SIZE = "24";
  #environment.variables.NIX_CFLAGS_COMPILE="-flags1 -flags2";
  console = {
    earlySetup = true;
    colors = [
      "24273a"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "cad3f5"
      "5b6078"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "a5adcb"
    ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = [ "teal" ]; };
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "teal" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "macchiato";
    };
    #  warp-beta = import (fetchTarball "https://github.com/imadnyc/nixpkgs/archive/refs/heads/warp-terminal-initial-linux.zip") {
    #         config = config.nixpkgs.config;  
    #     };

  };


  #theme fi

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ntfs3g
    nano
    home-manager
    #  vim # No olvides añadir un editor para editar configuration.nix! El editor Nano también está instalado por defecto.
    wget
    htop
    docker-compose
    appimage-run
    appimagekit
 neovim
 (retroarch.override {
    cores = with libretro; [
      genesis-plus-gx
      snes9x
      beetle-psx-hw
      mupen64plus

    ];
  })

  ];

  # appimageTools = {
  #   wrapType1 = {
  #     name = "patchwork";
  #     src = pkgs.fetchurl {
  #       url = "https://github.com/ssbc/patchwork/releases/download/v3.11.4/Patchwork-3.11.4-linux-x86_64.AppImage";
  #       hash = "sha256-OqTitCeZ6xmWbqYTXp8sDrmVgTNjPZNW0hzUPW++mq4=";
  #     };
  #     extraPkgs = pkgs: with pkgs; [ ];
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.wireless.userControlled.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
   #   experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
    
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;

    };
    kdeconnect = {
      enable = true;
    };
    #   git = { 
    #   enable = true;
    #   userName = "elbatlles";
    #   userEmail = "angelbatlles@gmail.com";
    # };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "robbyrussell";
      };
    };
    xwayland.enable = true;

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];

    dconf.enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
  fonts.packages = with pkgs; [

    noto-fonts
    fira-code
    noto-fonts-cjk
    jetbrains-mono
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

}
