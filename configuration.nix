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
    ./modules/hermes.nix
    ./modules/ollama.nix
    
    #mostly on modules cuz i want to keep it organized and also i want to be able to easily add or remove modules without having to edit the main configuration file and also i want to be able to easily share my configuration with others without having to share the entire configuration file just share the modules that they are interested in so yeah if you want to add something just add it to the appropriate module and it will work by default
    ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };
  #system.rebuild.enableNg = false;
  # Kernel - Latest for best AMD support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Swap - 8 GiB swapfile on the root filesystem
  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  boot.kernel.sysctl."vm.swappiness" = 100;

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
  "d /home/jsdev/projects 2775 jsdev devs -"
  "d /home/php/projects 2775 php devs -"
  "d /home/pydev/projects 2775 pydev devs -"
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

  systemd.services.project-acls = {
    description = "Normalize shared project ownership and ACLs";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" "systemd-tmpfiles-setup.service" ];
    unitConfig.ConditionPathExists = "!/var/lib/project-acls.done";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      set -eu
      for spec in "jsdev /home/jsdev/projects" "php /home/php/projects" "pydev /home/pydev/projects"; do
        set -- $spec
        user="$1"
        dir="$2"
        [ -d "$dir" ] || continue
        ${pkgs.coreutils}/bin/chown -R "$user:devs" "$dir"
        ${pkgs.coreutils}/bin/chmod -R g+rwX "$dir"
        ${pkgs.findutils}/bin/find "$dir" -type d -exec ${pkgs.coreutils}/bin/chmod g+s {} +
        ${pkgs.acl}/bin/setfacl -R -m g:devs:rwX "$dir"
        ${pkgs.findutils}/bin/find "$dir" -type d -exec ${pkgs.acl}/bin/setfacl -m d:g:devs:rwx {} +
      done
      ${pkgs.coreutils}/bin/touch /var/lib/project-acls.done
    '';
  };

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
    cleanup = "sudo nix-collect-garbage --delete-older-than 14d";
    charge100 = "echo 100 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold";
    charge80  = "echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold";
  };

  system.stateVersion = "24.05";
}
