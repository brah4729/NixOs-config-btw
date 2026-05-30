{ config, pkgs, ... }:

{
  # User configuration for user e 
  users.users.e = {
    isNormalUser = true;
    description = "e";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" ];
    shell = pkgs.bash; # or pkgs.zsh, pkgs.fish — whatever you use
  };
   users.users.jsdev = {
    isNormalUser = true;
    description = "jsdev";
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.bash;
    initialPassword = "changeme";  # set a temp password
  };

  users.users.php = {
    isNormalUser = true;
    description = "php";
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.bash;
    initialPassword = "changeme";
  };

  users.users.pydev = {
    isNormalUser = true;
    description = "pydev";
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.bash;
    initialPassword = "changeme";
  };
}