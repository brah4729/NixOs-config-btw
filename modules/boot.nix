{ lib, pkgs, ... }:

{
  #for safe boot cause i need to play warzone
  #./modules/boot.nix
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}