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
    ./modules/users.nix
    ./modules/battery.nix
    ./modules/ssh.nix
    ./modules/boot.nix
    
    #mostly on modules cuz i want to keep it organized and also i want to be able to easily add or remove modules without having to edit the main configuration file and also i want to be able to easily share my configuration with others without having to share the entire configuration file just share the modules that they are interested in so yeah if you want to add something just add it to the appropriate module and it will work by default
    ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Kernel - Latest for best AMD support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking = {
    hostName = "nixos-main";
    networkmanager.enable = true;
    useDHCP = false;
  };

  # Time zone and locale
  time.timeZone = "Asia/Jakarta";  # CHANGE TO YOUR TIMEZONE
  i18n.defaultLocale = "en_US.UTF-8";

systemd.tmpfiles.rules = [
  "d /home/e/projects 0755 e users -"
  "d /home/e/projects/py 0755 e users -"
  "d /home/e/projects/php 0755 e users -"
  "d /home/e/projects/js 0755 e users -"
];

# 2. Bind-mount each user's project folder into e's tree
fileSystems."/home/e/projects/py" = {
  device = "/home/pydev/projects";
  fsType = "none";
  options = [ "bind" "x-systemd.requires-mounts-for=/home/pydev" ];
};

fileSystems."/home/e/projects/php" = {
  device = "/home/php/projects";
  fsType = "none";
  options = [ "bind" "x-systemd.requires-mounts-for=/home/php" ];
};

fileSystems."/home/e/projects/js" = {
  device = "/home/jsdev/projects";
  fsType = "none";
  options = [ "bind" "x-systemd.requires-mounts-for=/home/jsdev" ];
};

 users.groups.devs = {};
  users.users.e.extraGroups = [ "devs" ];
  users.users.pydev.extraGroups = [ "devs" ];
  users.users.php.extraGroups = [ "devs" ];
  users.users.jsdev.extraGroups = [ "devs" ];

  # Optional: Enable the Oracle Extension Pack (required for USB 2.0/3.0 support)
  # Note: This requires accepting a proprietary license
  # AMD Graphics
hardware.graphics = {
  enable = true;
  enable32Bit = true;   # replaces driSupport32Bit, useful for Steam/games
};
services.xserver.videoDrivers = ["amdgpu"];
  # Allow unfree packages
   nixpkgs.config.allowUnfree = true;

  # Environment variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

#systemd.targets.sleep.enable = false;
#systemd.targets.suspend.enable = false;
systemd.targets.hibernate.enable = false;
#systemd.targets.hybrid-sleep.enable = false;
  # Shell aliases
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-main";
    rebuild-boot = "sudo nixos-rebuild boot --flake /etc/nixos#nixos-main";
    update = "sudo nix flake update /etc/nixos && rebuild";
    cleanup = "sudo nix-collect-garbage -d";
  };

  system.stateVersion = "24.05";
}
