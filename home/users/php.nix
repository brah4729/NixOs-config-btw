{ pkgs, ... }:

{
  imports = [ ../default.nix ];

  home.username = "php";
  home.homeDirectory = "/home/php";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    php
    phpExtensions.xdebug
    phpExtensions.pcov
    phpExtensions.phpunit
    phpExtensions.composer
  ];
}