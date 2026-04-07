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
    
    # Utilities
    unzip
    zip
    tree
    wineWowPackages.waylandFull
    #pkgs.winboat
    
    # GUI Text Editors
     vscode     # Temporarily disabled - may have insecure deps
    # sublime4   # Temporarily disabled - may have insecure deps
    # Terminal utilities
    ripgrep
    fd
    eza
#decorations 
    cmatrix 
    cava 
  ];
  
}