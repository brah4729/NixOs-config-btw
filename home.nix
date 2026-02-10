{ config, pkgs, inputs, ... }:

{
  home.username = "e";
  home.homeDirectory = "/home/e";
  home.stateVersion = "24.05";

 
 programs.home-manager.enable = true;
programs.spicetify = {
    enable = true;
    # Theme configuration
    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
    colorScheme = "mocha";
    
    # Optional: Add extensions
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      adblock           # Blocks Spotify ads
      fullAppDisplay    # Shows full app name in title
      shuffle           # Enhanced shuffle
      # marketplace     # Extension browser (enabled by default)
    ];
  };


  # Git configuration
  programs.git = {
    enable = true;
    userName = "brah4729";  # CHANGE THIS
    userEmail = "brah4729@users.noreply.github.com";  # CHANGE THIS
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
      ls = "eza --icons";
      cat = "bat";
      ".." = "cd ..";
      btw = "echo 'I use NixOS btw'";
    };
    
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };

  # Neovim with LazyVim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter.withAllGrammars
    ];
    
    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- LazyVim setup
      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })

      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = "a"
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
    '';
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$terminal2" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";
      
      monitor = ",preferred,auto,1";
      
      exec-once = [
        "waybar"
        "dunst"
        "swww init"
	"swww-daemon"
	"swww img /etc/nixos/images/NixOs.jpg"
        "nm-applet --indicator"
        "blueman-applet"
      ];
      
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
      
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      decoration = {
        rounding = 10;
        
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      
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
      
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      
      master = {
        new_is_master = true;
      };
      
      gestures = {
        workspace_swipe = true;
      };
      
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
      
      # Keybindings
      bind = [
        # Applications
        "CTRL_ALT, T, exec, $terminal"
        "$mod SHIFT, Q, exec, $terminal2"
        "$mod, E, exec, $fileManager"
        "$mod, R, exec, $menu"
        "CTRL_ALT, B, exec, firefox"
        "$mod, N, exec, $terminal nvim"
        
        # Window management
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, F, fullscreen"
        
        # Focus movement (VIM keys)
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        
        # Focus movement (Arrow keys)
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        # Window movement
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        
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
        "SHIFT, Print, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
      ];
      
      # Volume and brightness bindings
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      
      # Locked bindings (work even when locked)
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

  # Waybar - Use xdg.configFile to write JSONC and CSS files
  xdg.configFile."waybar/config.jsonc".text = ''
    {
      "layer": "top",
      "position": "top",
      "height": 36,
      "spacing": 8,
      "margin-top": 8,
      "margin-left": 12,
      "margin-right": 12,
      "modules-left": [
        "hyprland/workspaces",
        "hyprland/window"
      ],
      "modules-center": [
        "clock"
      ],
      "modules-right": [
        "tray",
        "cpu",
        "memory",
        "idle_inhibitor",
        "backlight",
        "pulseaudio",
        "network",
        "bluetooth",
        "battery",
        "custom/power"
      ],
      
      "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
          "1": "󰲠",
          "2": "󰲢",
          "3": "󰲤",
          "4": "󰲦",
          "5": "󰲨",
          "6": "󰲪",
          "7": "󰲬",
          "8": "󰲮",
          "9": "󰲰",
          "10": "󰿬"
        },
        "persistent-workspaces": {
          "*": 5
        }
      },
      
      "hyprland/window": {
        "format": "{}",
        "max-length": 50,
        "separate-outputs": true
      },
      
      "clock": {
        "timezone": "Asia/Kolkata",
        "format": "{:%H:%M}",
        "format-alt": "{:%A, %B %d, %Y (%R)}",
        "tooltip-format": "<tt><small>{calendar}</small></tt>",
        "calendar": {
          "mode": "year",
          "mode-mon-col": 3,
          "weeks-pos": "right",
          "on-scroll": 1,
          "format": {
            "months": "<span color='#ffead3'><b>{}</b></span>",
            "days": "<span color='#ecc6d9'><b>{}</b></span>",
            "weeks": "<span color='#99ffdd'><b>W{}</b></span>",
            "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
            "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
          }
        },
        "actions": {
          "on-click-right": "mode",
          "on-click-forward": "tz_up",
          "on-click-backward": "tz_down",
          "on-scroll-up": "shift_up",
          "on-scroll-down": "shift_down"
        }
      },
      
      "tray": {
        "icon-size": 18,
        "spacing": 8
      },
      
      "cpu": {
        "format": "󰻠 {usage}%",
        "format-alt": "󰻠 {avg_frequency} GHz",
        "interval": 1,
        "tooltip": true,
        "tooltip-format": "CPU Usage: {usage}%\nAverage Frequency: {avg_frequency} GHz\nLoad: {load}"
      },
      
      "memory": {
        "format": "󰍛 {percentage}%",
        "format-alt": "󰍛 {used:0.1f}G/{total:0.1f}G",
        "interval": 1,
        "tooltip": true,
        "tooltip-format": "Memory Usage: {percentage}%\nUsed: {used:0.2f} GB\nAvailable: {avail:0.2f} GB\nTotal: {total:0.2f} GB"
      },
      
      "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
          "activated": "󰒳",
          "deactivated": "󰒲"
        }
      },
      
      "backlight": {
        "device": "intel_backlight",
        "format": "{icon} {percent}%",
        "format-icons": ["󰃞", "󰃟", "󰃠"],
        "scroll-step": 5,
        "smooth-scrolling-threshold": 1,
        "tooltip": true,
        "tooltip-format": "Brightness: {percent}%",
        "on-scroll-up": "brightnessctl set 5%+",
        "on-scroll-down": "brightnessctl set 5%-"
      },
      
      "pulseaudio": {
        "scroll-step": 5,
        "format": "{icon} {volume}%",
        "format-muted": "󰖁 Muted",
        "format-icons": {
          "headphone": "󰋋",
          "hands-free": "󱡏",
          "headset": "󰋎",
          "phone": "󰏲",
          "portable": "󰦧",
          "car": "󰄋",
          "default": ["󰕿", "󰖀", "󰕾"]
        },
        "on-click": "pavucontrol",
        "on-click-right": "pactl set-sink-mute @DEFAULT_SINK@ toggle"
      },
      
      "network": {
        "format-wifi": "󰤨 {signalStrength}%",
        "format-ethernet": "󰈀 Connected",
        "format-linked": "󰈀 {ifname} (No IP)",
        "format-disconnected": "󰤭 Disconnected",
        "tooltip-format": "{ifname} via {gwaddr}",
        "tooltip-format-wifi": "{essid} ({signalStrength}%) 󰤨",
        "tooltip-format-ethernet": "{ifname} 󰈀",
        "tooltip-format-disconnected": "Disconnected",
        "max-length": 50,
        "on-click": "nm-connection-editor"
      },
      
      "bluetooth": {
        "format": "󰂯",
        "format-disabled": "󰂲",
        "format-off": "󰂲",
        "format-on": "󰂯",
        "format-connected": "󰂱 {num_connections}",
        "tooltip-format": "{controller_alias}\t{controller_address}",
        "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
        "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
        "on-click": "blueman-manager"
      },
      
      "battery": {
        "states": {
          "warning": 30,
          "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": "󰂄 {capacity}%",
        "format-plugged": "󰚥 {capacity}%",
        "format-alt": "{icon} {time}",
        "format-icons": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
      },
      
      "custom/power": {
        "format": "⏻",
        "tooltip": false,
        "on-click": "wlogout"
      }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    /* Modern Aesthetic Waybar Theme */
    * {
      font-family: "JetBrains Mono", "SF Pro Display", "Helvetica Neue", sans-serif;
      font-size: 13px;
      font-weight: 500;
      border: none;
      border-radius: 0;
      min-height: 0;
    }

    window#waybar {
      background: linear-gradient(135deg, rgba(30, 30, 46, 0.85), rgba(24, 24, 37, 0.85));
      background:transparent;
      border-radius: 16px;
      border: 1px solid rgba(205, 214, 244, 0.15);
      margin: 8px;
      padding: 4px 8px;
      transition: all 0.3s ease;
    }

    window#waybar:hover {
      background: linear-gradient(135deg, rgba(30, 30, 46, 0.95), rgba(24, 24, 37, 0.95));
      border-color: rgba(205, 214, 244, 0.25);
    }

    window#waybar.hidden {
      opacity: 0.2;
    }

    /* Left modules */
    #workspaces {
      background: rgba(49, 50, 68, 0.8);
      border-radius: 10px;
      margin: 4px 8px;
      padding: 0 4px;
      border: 1px solid rgba(205, 214, 244, 0.05);
    }

    #workspaces button {
      padding: 6px 12px;
      margin: 2px;
      color: rgba(205, 214, 244, 0.6);
      background: transparent;
      border-radius: 8px;
      transition: all 0.3s ease;
      border: 1px solid transparent;
    }

    #workspaces button:hover {
      background: rgba(137, 180, 250, 0.1);
      color: #89b4fa;
      border-color: rgba(137, 180, 250, 0.2);
    }

    #workspaces button.active {
      background: linear-gradient(135deg, #89b4fa, #74c7ec);
      color: #1e1e2e;
      border-color: rgba(137, 180, 250, 0.3);
    }

    #workspaces button.urgent {
      background: linear-gradient(135deg, #f38ba8, #eba0ac);
      color: #1e1e2e;
      animation: urgent 1s ease-in-out infinite alternate;
    }

    @keyframes urgent {
      from { background: rgba(243, 139, 168, 0.3); }
      to { background: rgba(243, 139, 168, 0.6); }
    }

    #window {
      background: linear-gradient(135deg, rgba(49, 50, 68, 0.8), rgba(40, 42, 54, 0.8));
      border-radius: 12px;
      margin: 4px 8px;
      padding: 8px 16px;
      color: #cdd6f4;
      border: 1px solid rgba(205, 214, 244, 0.1);
      font-weight: 500;
      transition: all 0.3s ease;
    }

    #window:hover {
      background: linear-gradient(135deg, rgba(49, 50, 68, 0.9), rgba(40, 42, 54, 0.9));
      border-color: rgba(205, 214, 244, 0.2);
    }

    #window.empty {
      background: transparent;
      border: none;
    }

    /* Center module */
    #clock {
      background: linear-gradient(135deg, rgba(137, 180, 250, 0.2), rgba(116, 199, 236, 0.2));
      border-radius: 12px;
      margin: 4px 8px;
      padding: 10px 24px;
      color: #cdd6f4;
      border: 1px solid rgba(137, 180, 250, 0.3);
      font-weight: 700;
      font-size: 15px;
      transition: all 0.3s ease;
    }

    #clock:hover {
      background: linear-gradient(135deg, rgba(137, 180, 250, 0.3), rgba(116, 199, 236, 0.3));
      border-color: rgba(137, 180, 250, 0.5);
    }

    /* Right modules */
    #tray,
    #cpu,
    #memory,
    #backlight,
    #idle_inhibitor,
    #pulseaudio,
    #network,
    #bluetooth,
    #battery,
    #custom-power {
      background: rgba(49, 50, 68, 0.8);
      border-radius: 10px;
      margin: 4px 2px;
      padding: 8px 12px;
      color: #cdd6f4;
      border: 1px solid rgba(205, 214, 244, 0.05);
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    #tray {
      padding: 8px 8px;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: rgba(243, 139, 168, 0.2);
    }

    /* Module hover effects */
    #idle_inhibitor:hover,
    #cpu:hover,
    #memory:hover,
    #backlight:hover,
    #pulseaudio:hover,
    #network:hover,
    #bluetooth:hover,
    #battery:hover {
      background: linear-gradient(135deg, rgba(166, 227, 161, 0.2), rgba(148, 226, 213, 0.2));
      border-color: rgba(166, 227, 161, 0.4);
    }

    /* Specific module colors */
    #cpu {
      color: #fab387;
    }

    #cpu.warning {
      color: #f9e2af;
      background: rgba(249, 226, 175, 0.1);
    }

    #cpu.critical {
      color: #f38ba8;
      background: rgba(243, 139, 168, 0.1);
      animation: blink 0.5s linear infinite alternate;
    }

    #memory {
      color: #cba6f7;
    }

    #memory.warning {
      color: #f9e2af;
      background: rgba(249, 226, 175, 0.1);
    }

    #memory.critical {
      color: #f38ba8;
      background: rgba(243, 139, 168, 0.1);
      animation: blink 0.5s linear infinite alternate;
    }

    #pulseaudio {
      color: #a6e3a1;
    }

    #pulseaudio.muted {
      color: #f38ba8;
      background: rgba(243, 139, 168, 0.1);
    }

    #network {
      color: #74c7ec;
    }

    #network.disconnected {
      color: #f38ba8;
      background: rgba(243, 139, 168, 0.1);
    }

    #bluetooth {
      color: #89b4fa;
    }

    #bluetooth.disabled,
    #bluetooth.off {
      color: rgba(205, 214, 244, 0.4);
    }

    #battery {
      color: #a6e3a1;
    }

    #battery.charging,
    #battery.plugged {
      color: #f9e2af;
      background: rgba(249, 226, 175, 0.1);
    }

    #battery.critical:not(.charging) {
      background: rgba(243, 139, 168, 0.15);
      color: #f38ba8;
      animation: blink 0.5s linear infinite alternate;
    }

    #battery.warning:not(.charging) {
      color: #f9e2af;
      background: rgba(249, 226, 175, 0.1);
    }

    @keyframes blink {
      to {
        background-color: rgba(243, 139, 168, 0.3);
        color: #ffffff;
      }
    }

    #idle_inhibitor {
      color: #cba6f7;
    }

    #idle_inhibitor.activated {
      background: rgba(203, 166, 247, 0.15);
      color: #cba6f7;
    }

    #custom-power {
      color: #f38ba8;
      font-size: 16px;
      background: linear-gradient(135deg, rgba(243, 139, 168, 0.2), rgba(235, 160, 172, 0.2));
      border-color: rgba(243, 139, 168, 0.3);
    }

    #custom-power:hover {
      background: linear-gradient(135deg, rgba(243, 139, 168, 0.3), rgba(235, 160, 172, 0.3));
      border-color: rgba(243, 139, 168, 0.5);
    }

    /* Tooltip styling */
    tooltip {
      background: linear-gradient(135deg, rgba(30, 30, 46, 0.95), rgba(24, 24, 37, 0.95));
      border: 1px solid rgba(205, 214, 244, 0.2);
      border-radius: 10px;
      color: #cdd6f4;
      font-weight: 500;
      padding: 8px 12px;
    }

    tooltip label {
      color: #cdd6f4;
      padding: 2px 4px;
    }
  '';

  # Still enable Waybar through Home Manager
  programs.waybar.enable = true;

  # Rofi - Custom launcher
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

  # Kitty terminal
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    font = {
      name = "monospace-mono";
      size = 12;
    };
    settings = {
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 10;
    };
  };

  # Foot terminal - Fast Wayland terminal
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=12";
        dpi-aware = "yes";
      };
      
      mouse = {
        hide-when-typing = "yes";
      };
      
      colors = {
        alpha = "0.95";
        # Tokyo Night colors
        background = "1a1b26";
        foreground = "c0caf5";
        
        regular0 = "15161e";
        regular1 = "f7768e";
        regular2 = "9ece6a";
        regular3 = "e0af68";
        regular4 = "7aa2f7";
        regular5 = "bb9af7";
        regular6 = "7dcfff";
        regular7 = "a9b1d6";
        
        bright0 = "414868";
        bright1 = "f7768e";
        bright2 = "9ece6a";
        bright3 = "e0af68";
        bright4 = "7aa2f7";
        bright5 = "bb9af7";
        bright6 = "7dcfff";
        bright7 = "c0caf5";
      };
    };
  };

  # Firefox
  programs.firefox = {
    enable = true;
  };

  #fastfetch
# In your home-manager configuration
  programs.fastfetch = {
    enable = true;
    
    # Package can be customized if needed
    # package = pkgs.fastfetch;
    
    settings = {
      logo = {
        type = "nixos";
        width = 35;
        color = {
          keys = [ "#7EBAE4" "#5277C3" ];
        };
      };
      
      display = {
        keyColor = "#7EBAE4";
        valueColor = "#5277C3";
      };
      
      modules = [
        {
          type = "title";
          format = "{0}@{1}";
          args = [ "user" "host" ];
        }
        "separator"
        {
          type = "os";
          key = "OS";
        }
        {
          type = "host";
          key = "Host";
        }
        {
          type = "kernel";
          key = "Kernel";
        }
        {
          type = "uptime";
          key = "Uptime";
        }
        {
          type = "packages";
          key = "Packages";
          format = "{} (nix)";
        }
        {
          type = "shell";
          key = "Shell";
        }
        {
          type = "terminal";
          key = "Terminal";
        }
        {
          type = "cpu";
          key = "CPU";
          compact = true;
        }
        {
          type = "gpu";
          key = "GPU";
        }
        {
          type = "memory";
          key = "Memory";
        }
        {
          type = "disk";
          key = "Disk";
        }
        "separator"
      ];
    };
  };

  # Additional packages
  home.packages = with pkgs; [
    # System utilities
    btop
    neofetch
    fastfetch
    playerctl
    pavucontrol
    
    # Development
    gcc
    nodejs
    python3
    
    # Media
    mpv
    imv
    
    # Office
    libreoffice-fresh
    
    # System tools
    brightnessctl
    wlogout
    
    # Archive
    p7zip
    unrar
    
    # Icons
    papirus-icon-theme
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # Create LazyVim config directory
  home.file.".config/nvim/lua/plugins/.keep".text = "";
}
