{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # User account
  users.users.e = {
    isNormalUser = true;
    description = "Main User";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.bash;
    initialPassword = "69420";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak
  services.flatpak.enable = true;

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
    
    # GUI Text Editors
    # vscode     # Temporarily disabled - may have insecure deps
    # sublime4   # Temporarily disabled - may have insecure deps
    
    # Terminal utilities
    ripgrep
    fd
    eza
  ];

  # Fonts
fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-color-emoji
  font-awesome
  jetbrains-mono
  fira-code
  hack-font 
  nerd-fonts.jetbrains-mono
  
 ];
 fonts.fontconfig = {
  enable = true;
  defaultFonts = {
    monospace = [ "JetBrains Mono Nerd Font" "DejaVu Sans Mono" ];
    sansSerif = [ "Noto Sans" "DejaVu Sans" ];
    serif = [ "Noto Serif" "DejaVu Serif" ];
  };
};

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

  # Shell aliases
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-main";
    update = "sudo nix flake update /etc/nixos && rebuild";
    cleanup = "sudo nix-collect-garbage -d";
  };

  system.stateVersion = "24.05";
}
