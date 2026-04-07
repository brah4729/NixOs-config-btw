{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/desktop.nix
    ./modules/fonts.nix
    ./modules/docker.nix
    ./modules/obs.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Kernel - Latest for best AMD support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking = {
    hostName = "nixos-main";
    networkmanager.enable = true;
  };

  # Time zone and locale
  time.timeZone = "America/New_York";  # CHANGE THIS
  i18n.defaultLocale = "en_US.UTF-8";

  # AMD Graphics
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    #driSupport32Bit = true;
  };
services.xserver.videoDrivers = ["amdgpu"];

  # User account
  users.users.e = {
    isNormalUser = true;
    description = "Main User";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    shell = pkgs.bash;
    initialPassword = "nixosbtw";
  };

  # Allow unfree packages
   nixpkgs.config.allowUnfree = true;


  # System packages
  environment.systemPackages = with pkgs; [
    # Essential
    vim
    wget
    git
    curl
    htop

    # Terminals
    kitty
    foot
    
    # Hyprland essentials
    waybar
    dunst
    rofi
    swww
    
    # File management
    thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    
    # Screenshots
    grim
    slurp
    wl-clipboard
    
    # Network
    networkmanagerapplet
    
    # Utilities
    unzip
    zip
    tree
    wineWowPackages.waylandFull
    #pkgs.winboat
    
    # GUI Text Editors
     vscode     # Temporarily disabled - may have insecure deps
    # sublime4   # Temporarily disabled - may have insecure deps
    # Terminal utilities
    ripgrep
    fd
    eza
#decorations 
    cmatrix 
    cava \
  ];
  
# Enable flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Environment variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
nix.settings = {
    # CRITICAL: Resource limits
    cores = 4;
    max-jobs = 1;
    
    # CRITICAL: Use binary cache, don't build
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"  # For CUDA packages
    ];
    
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
    
    # Don't build if not in cache - just fail instead
    fallback = false;
    
    # Keep system responsive
    min-free = 4294967296;  # Keep 4GB free
   }; 

  # Shell aliases
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-main";
    update = "sudo nix flake update /etc/nixos && rebuild";
    cleanup = "sudo nix-collect-garbage -d";
  };

  system.stateVersion = "24.05";
}
