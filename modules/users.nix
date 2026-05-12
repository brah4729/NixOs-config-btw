{ config, pkgs, ... }:

{
  users.users.e = {
    isNormalUser = true;
    description = "e";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" ];
    shell = pkgs.bash; # or pkgs.zsh, pkgs.fish — whatever you use
  };
}