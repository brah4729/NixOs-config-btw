{ pkgs, ... }:
#for laravel and composer and stuff like that just add whatever you want to the home.packages list and it will be installed by default
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