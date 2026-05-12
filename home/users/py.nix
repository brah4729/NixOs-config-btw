# /etc/nixos/home/users/pydev.nix
{ pkgs, ... }:

{
  imports = [ ../default.nix ];

  home.username = "pydev";
  home.homeDirectory = "/home/pydev";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    ruff          # fast linter
    pyright       # LSP
    poetry
    jupyter
  ];
}