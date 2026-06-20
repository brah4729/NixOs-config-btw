{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      # =============================================
      # VARIABLES
      # =============================================
      "$mod"         = "SUPER";
      "$terminal"    = "foot";
      "$terminal2"   = "kitty";
      "$fileManager" = "thunar";
      "$menu"        = "rofi -show drun";

      # =============================================
      # MONITOR
      # =============================================
      monitor = ",preferred,auto,1";

      # =============================================
      # AUTOSTART
      # =============================================
      exec-once = [
        "waybar"
        "dunst"
        "swww-daemon"
        "swww img /etc/nixos/images/wallpaper.gif" # change path to your wallpaper
        "nm-applet --indicator"
        "blueman-applet"
        "hypridle"
      ];

      # =============================================
      # ENVIRONMENT VARIABLES
      # =============================================
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "NIXOS_OZONE_WL,1"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      # =============================================
      # INPUT
      # =============================================
      input = {
        kb_layout    = "us";
        follow_mouse = 1;
        sensitivity  = 0;

        touchpad = {
          natural_scroll     = true;
          disable_while_typing = true;
        };
      };

      general = {
        gaps_in    = 5;
        gaps_out   = 10;
        border_size = 2;
        "col.active_border"   = "rgba(c0caf5ff)";
        "col.inactive_border" = "rgba(414868ff)";

        layout        = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 0;

        blur = {
          enabled  = true;
          size     = 5;
          passes   = 2;
          new_optimizations = true;
        };

        shadow = {
          enabled     = true;
          range       = 8;
          render_power = 3;
          color       = "rgba(1a1a2eee)";
        };

        # Dim inactive windows slightly
        dim_inactive   = true;
        dim_strength   = 0.05;
      };
      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "linear, 0.0, 0.0, 1.0, 1.0"
          "overshot, 0.13, 0.99, 0.29, 1.1"
        ];

        animation = [
          "windows,    1, 7,  myBezier"
          "windowsOut, 1, 7,  default, popin 80%"
          "windowsIn,  1, 7,  overshot, popin 80%"
          "border,     1, 10, default"
          "borderangle,1, 8,  default"
          "fade,       1, 7,  default"
          "workspaces, 1, 6,  overshot, slide"
        ];
      };

      # =============================================
      # LAYOUTS
      # =============================================
      dwindle = {
        pseudotile     = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
      };

      # =============================================
      # GESTURES
      # =============================================
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      # =============================================
      # MISC
      # =============================================
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo   = true;
        animate_manual_resizes  = true;
      };

      # =============================================
      # WINDOW RULES
      # =============================================
      windowrulev2 = [
        # Float file pickers
        "float, class:^(xdg-desktop-portal-gtk)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"

        # Blur terminal backgrounds
        "opacity 0.9 0.9, class:^(kitty)$"
        "opacity 0.9 0.9, class:^(foot)$"

        # Float common tools
        "float, class:^(pavucontrol)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(nm-connection-editor)$"
      ];

      # =============================================
      # KEYBINDINGS (your original — untouched)
      # =============================================
      bind = [
        # Applications
        "CTRL_ALT, T, exec, $terminal"
        "$mod SHIFT, Q, exec, $terminal2"
        "$mod, E, exec, $fileManager"
        "$mod, R, exec, $menu"
        "CTRL_ALT, B, exec, firefox"
        "$mod, N, exec, $terminal nvim"

        # Lock / logout
        "CTRL_ALT, L, exec, hyprlock"
        "CTRL_ALT, P, exec, wlogout"

        # Window management
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, F, fullscreen"
        "$mod SHIFT, F, resizeactive, exact 960 540"

        # Focus (VIM)
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Focus (Arrow keys)
        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"

        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Workspaces
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

        # Move to workspace
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

        # Special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Screenshots
        ", Print,       exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, Print,   exec, grim - | wl-copy"
        "SHIFT, Print,  exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
      ];

      # Volume / brightness (repeatable)
      bindel = [
        ", XF86AudioRaiseVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp,   exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      # Media keys (work on lockscreen too)
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
