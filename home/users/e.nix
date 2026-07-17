# /etc/nixos/home/users/e.nix
# my daily drive just for gaming, spicetify, and some other stuff that i use daily
{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ 
    ../default.nix 
     ../modules/noctalia.nix
     ../modules/niri.nix         
  ];

  home.username = "e";
  home.homeDirectory = "/home/e";
  home.stateVersion = "24.05";

  programs.spicetify = {
    enable = true;
    colorScheme = "TokyoNight";
    theme = spicePkgs.themes.text;
    enabledCustomApps = with spicePkgs.apps; [ marketplace ];
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
  };

  programs.firefox.enable = true;

  home.packages = with pkgs; [
    gcc
    nodejs
    mpv
    imv
    libreoffice-fresh
  ];

  # LazyVim plugin dir3
  home.file.".config/nvim/lua/plugins/.keep".text = "";
}