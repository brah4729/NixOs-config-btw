{ config, pkgs, inputs, ... }:
{
  # This is the main home-manager configuration file that is imported by all the users and it contains the common configuration for all the users and also imports the modules that are used by the users so yeah if you want to add something that is common for all the users just add it here and it will be applied to all the users by default
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/terminals.nix
    ./modules/editors.nix
    ./modules/rofi.nix
    ./modules/hyprlock.nix
    ./modules/hypridle.nix
    ./modules/fastfetch.nix
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
    initExtra = ''
    # Change the number '35' to choose a different color index
    export PS1="\[\e[0;37m\][\u@\h:\w]\$ \[\e[0m\]"
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
