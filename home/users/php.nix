# /etc/nixos/home/users/php.nix
# for laravel, composer and php dev stuff
{ pkgs, ... }:
{
  imports = [ ../default.nix ];

  home.username = "php";
  home.homeDirectory = "/home/php";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # PHP with extensions baked in
    (php.withExtensions ({ enabledExtensions, allExtensions }:
      enabledExtensions ++ (with allExtensions; [
        xdebug
        pcov
      ])
    ))

    # PHP tools (these are separate packages, not extensions)
    phpPackages.composer
    phpPackages.phpunit

    # Laravel helpers
    php83Packages.psysh   # REPL for debugging
    nodePackages.npm      # needed for Laravel Mix / Vite
  ];
}