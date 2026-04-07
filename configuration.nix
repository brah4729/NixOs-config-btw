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
    ./modules/packages.nix
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
