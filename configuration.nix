# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };


  networking.hostName = "vmw-nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1" "8.8.8.8" "9.9.9.9"];

  time.timeZone = "Europe/Copenhagen";

  hardware.graphics = { 
    enable = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      mesa
    ];
  };
  virtualisation.vmware.guest.enable = true;

  # internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    displayManager.sddm = {
	    enable = true;
	    enableHidpi = true;
	    wayland.enable = true;
	    settings = {
        General = {
          GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192";
        };
	    };
    };
    desktopManager.plasma6.enable = true;
    gnome.gnome-keyring.enable = true;
    cron.enable = true;
  };

  # sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  # touchpad support
  services.libinput.enable = true;

  # user account
  users.users.danyia = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };
  services.getty.autologinUser = "danyia";

  programs = {
    hyprland.enable = true;
    xwayland.enable = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      quarto = prev.quarto.overrideAttrs (old: {
        installPhase = ''
          runHook preInstall

          # Create the expected tools directory so Quarto (and Positron) can find its helpers
          mkdir -p $out/bin/tools
          ln -s ${prev.lib.getExe prev.pandoc} $out/bin/tools/pandoc
          ln -s ${prev.lib.getExe prev.deno} $out/bin/tools/deno
          ln -s ${prev.lib.getExe prev.esbuild} $out/bin/tools/esbuild
          ln -s ${prev.lib.getExe prev.typst} $out/bin/tools/typst


          # Include the remainder of the original installPhase
          ${old.installPhase}

          runHook postInstall
        '';
      });
    })
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # packages installed in system profile
  environment.systemPackages = with pkgs; [
    # essentials
    vim
    wget
    curl
    git
    unzip
    xorg.libxcvt
    glib
    imagemagick
    jq
    unzip
    libnotify
    binutils
    gcc
    libgcc
    pkg-config
    openssl
    cronie
    file
    libsecret
    tree

    # programs
    fzf
    bat
    htop
    csvtk
    sshfs-fuse
    qalculate-gtk
    vscode
    obsidian
    (rstudioWrapper.override {
      packages = with rPackages; [
        tidyverse
        patchwork
        ggridges
        ggbeeswarm
        table1
        ggseqlogo
        ggrepel
        tidymodels
        usethis
        here
        gitcreds
        devtools
        roxygen2
        testthat
        gert
        shiny
        golem
        gt
      ];
    })
    quarto
    sqlite
    brave

    # libreoffice
    libreoffice-qt
    hunspell
    hunspellDicts.en_US

    # for intro to bioinformatics TA
    geany

    # for running external programs
    nix-ld

    mesa

    # hyprland stuff
    waybar
    rofi-wayland
    wallust
    wl-clipboard
    ags
    cliphist
    loupe
    gtk-engine-murrine
    # hypridle
    libsForQt5.qtstyleplugin-kvantum
    nwg-displays
    nwg-look
    polkit_gnome
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
    slurp
    swappy
    swaynotificationcenter
    swww
    xarchiver
    yad
    bc
    grim
  ];

  environment.variables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    jetbrains-mono
    font-awesome
    nerd-fonts.jetbrains-mono
    helvetica-neue-lt-std
  ];
  fonts.enableDefaultPackages = true;
  fonts.enableGhostscriptFonts = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users
    };
  };

  services.envfs.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    glib
    zlib
    zlib.dev
    openssl
    openssl.dev
    curl
    curl.dev
    libtiff
    libtiff.dev
    nss
    libxml2
    libxml2.dev
    nspr
    dbus
    atk
    at-spi2-atk
    gtk3
    pango
    cairo
    mesa
    expat
    libxkbcommon
    libgbm
    systemd
    at-spi2-core
    cups
    alsa-lib
    sqlite.dev
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
  ];

  # Save disk space
  nix.optimise.automatic = true;

  # Run the GC daily keeping the 5 most recent generation of each profiles.
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than +5"; 
  };

  # Copy the NixOS configuration file and link it from the resulting system
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  system.stateVersion = "25.05";
}


