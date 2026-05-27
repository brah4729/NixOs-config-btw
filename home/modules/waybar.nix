{pkgs, ...}:
{
    # Waybar config btw thanks to a guy on github i just took it and edit it a bit here is the link to the original config
    #https://github.com/shivalingeshwar6/waybar-minimal
    #if you are the original author and want to take it down just email or dm me and i will take it down immediately
    #huge shout out to the original author for making this config and sharing it with the world its really good and i love it so yeah if you want to use it just enable waybar and it will work by default
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
        "timezone": "Asia/Jakarta",
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

  #
}
