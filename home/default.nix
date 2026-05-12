# /etc/nixos/home/default.nix
{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/terminals.nix
    ./modules/editors.nix
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "brah4729";
    userEmail = "brah4729@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -lah";
      ls = "eza --icons";
      ".." = "cd ..";
      btw = "echo 'I use NixOS btw'";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "DarkBlue";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = " Apps";
      display-run = " Run";
      display-window = " Window";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
      font = "jetbrains-mono 12";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # Base packages every user gets
  home.packages = with pkgs; [
    btop
    fastfetch
    playerctl
    pavucontrol
    brightnessctl
    wlogout
    p7zip
    unrar
    papirus-icon-theme
    eza
  ];
}