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
    (php.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
        xdebug
        pcov
      ]));
      extraConfig = "";
    })

    # PHP tools
    phpPackages.composer

    # Laravel helpers
    nodejs_22
  ];
}