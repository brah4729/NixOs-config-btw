# /etc/nixos/home/users/jsdev.nix
{ pkgs, ... }:

{
  imports = [ ../default.nix ];

  home.username = "jsdev";
  home.homeDirectory = "/home/jsdev";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    nodejs_22
    nodePackages.npm
    nodePackages.pnpm
    bun
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}