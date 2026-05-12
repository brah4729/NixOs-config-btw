{ config, pkgs, inputs, ... }:
{
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/terminals.nix
    ./modules/editors.nix
    ./modules/rofi.nix
    ./modules/hyprlock.nix
    ./modules/hypridle.nix
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

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

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
