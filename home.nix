{ config, pkgs, ... }:

{
  home.username = "e";
  home.homeDirectory = "/home/e";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Your Name";  # CHANGE THIS
    userEmail = "your.email@example.com";  # CHANGE THIS
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -lah";
      ".." = "cd ..";
      btw = "echo 'I use NixOS btw'";
    };
    
    # Auto-start Hyprland on TTY1
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
    '';
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      
      # Monitor configuration
      monitor = ",preferred,auto,1";
      
      # Autostart applications
      exec-once = [
        "waybar"
        "dunst"
        "swww init"
        "nm-applet --indicator"
        "blueman-applet"
      ];
      
      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
      
      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
        sensitivity = 0;
      };
      
      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      # Decoration
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      
      # Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      
      # Master layout
      master = {
        new_is_master = true;
      };
      
      # Gestures
      gestures = {
        workspace_swipe = true;
      };
      
      # Keybindings
      bind = [
        # Applications
        "$mod, Q, exec, kitty"
        "$mod, E, exec, thunar"
        "$mod, R, exec, rofi -show drun"
        "$mod, B, exec, firefox"
        
        # Window management
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        "$mod, F, fullscreen,"
        
        # Focus movement
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        
        # Window movement
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"
        
        # Workspace switching
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Special workspace
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
        
        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, Print, exec, grim - | wl-copy"
        
        # Audio
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        
        # Brightness
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      
      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  # Kitty terminal
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    settings = {
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
  };

  # Firefox
  programs.firefox = {
    enable = true;
  };

  # Additional packages
  home.packages = with pkgs; [
    # System utilities
    btop
    ripgrep
    fd
    eza
    bat
    
    # Media
    mpv
    imv
    
    # Office
    libreoffice-fresh
    
    # Brightness control
    brightnessctl
    
    # Archive tools
    p7zip
    unrar
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";
  };
}
