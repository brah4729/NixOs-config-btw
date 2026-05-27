# /etc/nixos/home/users/pydev.nix
# horay my favorite language just add whatever you want to the home.packages list and it will be installed by default mostly for machine learning 

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