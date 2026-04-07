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
    ./modules/nix-settings.nix
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
    cava 
(pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #for AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  })
  ];
  

  # Fonts
# fonts.packages = with pkgs; [
#   noto-fonts
#   noto-fonts-color-emoji
#   font-awesome
#   jetbrains-mono
#   fira-code
#   hack-font 
#   nerd-fonts.jetbrains-mono
  
#  ];
#  fonts.fontconfig = {
#   enable = true;
#   defaultFonts = {
#     monospace = [ "JetBrains Mono Nerd Font" "DejaVu Sans Mono" ];
#     sansSerif = [ "Noto Sans" "DejaVu Sans" ];
#     serif = [ "Noto Serif" "DejaVu Serif" ];
#   };
# };

  # Environment variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };


  # Shell aliases
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-main";
    update = "sudo nix flake update /etc/nixos && rebuild";
    cleanup = "sudo nix-collect-garbage -d";
  };

  system.stateVersion = "24.05";
}
