# /etc/nixos/home/users/jsdev.nix
# for my js development needs and stuff like that 
#mostly just typescrip, bun and npm 
{ pkgs, ... }:

{
  imports = [ ../default.nix ];

  home.username = "jsdev";
  home.homeDirectory = "/home/jsdev";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    nodePackages.npm
    nodePackages.pnpm
    bun
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}