{config, pkgs, ...}:
{
    # System packages
  environment.systemPackages = with pkgs; [
    # Essential
    vim
    wget
    git
    curl
    htop

    # Terminals
    kitty
    foot

    # Hyprland essentials
    waybar
    dunst
    rofi
    swww

    # File management
    thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman

    # Screenshots
    grim
    slurp
    wl-clipboard

    # Network
    networkmanagerapplet
    openssh

    # Utilities
    unzip
    zip
    tree
    wineWowPackages.waylandFull
    alsa-utils
    supertux #this is important for uhhh idk its just fun game to play and it works well on linux so yeah btw if you remove this the system fails to boot and you have to reinstall nixos so yeah dont remove this one its really important
    #pkgs.winboat

    # GUI Text Editors
     vscode     # Temporarily disabled - may have insecure deps
     zed-editor
    # sublime4   # Temporarily disabled - may have insecure deps
    # Terminal utilities
    ripgrep
    fd
    eza
#decorations
    cmatrix
    cava
    #etc
    discord
    #lockscreen
    hyprlock
    hypridle
  ];

}
