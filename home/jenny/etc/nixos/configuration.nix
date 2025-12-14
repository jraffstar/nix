{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      # Home manger
      <home-manager/nixos>
    ];

# Home manager configuration for user jenny
home-manager.users.jenny = {
xdg.configFile."mimeapps.list".force = true;
	home.stateVersion = "25.11";  

	xdg = { 
   
		mime.enable = true;

		mimeApps = {

		enable = true;
		};
	};
};

  # Grub bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";  
  boot.loader.efi.canTouchEfiVariables = true;  
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.gfxmodeBios = "1920x1080";  # for BIOS, or
  boot.loader.grub.gfxmodeEfi = "1920x1080";   # for EFI
  boot.loader.grub.gfxpayloadBios = "keep";
  boot.loader.grub.splashImage = "/etc/nixos/output.png";
  boot.loader.timeout = 10;
  boot.initrd.luks.devices."luks-0a628cdc-161d-4658-8d7b-87e2278e4476".device = "/dev/disk/by-uuid/0a628cdc-161d-4658-8d7b-87e2278e4476";


  networking.hostName = "nyaxos"; # Define your hostname.
  networking.wireless.iwd.enable = true; # Enable IWD
  networking.wireless.iwd.settings = {
	IPv6 = {
		Enabled = true;
	};
	Settings = {
		AutoConnect = true;
	};
};

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

 # Define a user account. Don't forget to set a password with ‘passwd’.
 programs.zsh.enable = true; 
 users.users.jenny = {
    isNormalUser = true;
    description = "jenny";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # X11
  services.displayManager.ly.enable = true;
  services.xserver = {
	enable = true;

    libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
      };

      # disabling touchpad acceleration
      touchpad = {
        accelProfile = "flat";
      };
    };

	windowManager.i3 = {
		enable = true;
		extraPackages = with pkgs; [
			i3status
			dmenu
		];
	};
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System packages
    lm_sensors
    gcc
    libx11
    libxft
    libxinerama
    zsh
    htop
    parted
    unzip
    unrar
    gnumake
    xdg-utils
    xdg-desktop-portal
    kdePackages.xdg-desktop-portal-kde
    ventoy-full 


    # GUI apps
    waypaper
    picom
    rofi
    volumeicon
    kitty


    # Utilities
    vim
    git
    lf
    feh
    flameshot
    fastfetch
    emacs
    vlc
    obs-studio
    gimp
    simplescreenrecorder
    filezilla
    imagemagick
    kdePackages.kdenlive
    pkgs.kdePackages.gwenview
    kiwix

    # Utilities/Dolphin
    kdePackages.dolphin
    pkgs.kdePackages.kservice
    pkgs.kdePackages.dolphin-plugins
    pkgs.kdePackages.baloo-widgets
    pkgs.kdePackages.baloo
    gnome-menus


    # Browsers + Comms
    librewolf
    tor-browser
    vesktop


    # Development
    vscode

    
    # Games
    superTuxKart


    # Office
    libreoffice
    projectlibre


    # Python Packages
    (python3.withPackages (ps: with ps; [ pip tkinter ]))

];

# Needed to install ventoy-full SECURITY RISK
nixpkgs.config.permittedInsecurePackages = [
  "ventoy-1.1.07"
];

# Dolphin default apps fix
    environment.etc."xdg/menus/applications.menu".source =
      "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

# Fonts
fonts.packages = with pkgs; [
        undefined-medium
        termsyn
        tamsyn
        fira-code
        comic-mono
        liberation_ttf
];

  system.stateVersion = "25.11"; # Did you read the comment?

}
