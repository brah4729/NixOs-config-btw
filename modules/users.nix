{ config, pkgs, ... }:

{
  # User configuration for user e 
  users.users.e = {
    isNormalUser = true;
    description = "e";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" ];
    shell = pkgs.bash; # or pkgs.zsh, pkgs.fish — whatever you use
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwLPNHP7rct2PX2hviU2v2T4rk/LP+GkISUxbyzznpP helloxdlolidc@gmail.com"
    ];
  };
   users.users.jsdev = {
    isNormalUser = true;
    description = "jsdev";
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.bash;
  };

  users.users.php = {
    isNormalUser = true;
    description = "php";
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.bash;
  };

  users.users.pydev = {
    isNormalUser = true;
    description = "pydev";
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.bash;
  };
}