{ inputs, pkgs, ... }:
{


  programs.niri.settings = {
    input = {
      keyboard.xkb.layout = "us";
      touchpad = {
        natural-scroll = true;
        tap = true;
      };
    };

    outputs."*".scale = 1.0;

    spawn-at-startup = [
      { command = [ "xwayland-satellite" ]; }
      { command = [ "nm-applet" "--indicator" ]; }
      { command = [ "blueman-applet" ]; }
      { command = [ "dunst" ]; }
    ];

    binds = with pkgs; {
      # Applications
      "Ctrl+Alt+T".action.spawn = [ "foot" ];
      "Mod+Shift+Q".action.spawn = [ "kitty" ];
      "Mod+E".action.spawn = [ "thunar" ];
      "Mod+R".action.spawn = [ "rofi" "-show" "drun" ];
      "Ctrl+Alt+B".action.spawn = [ "firefox" ];
      "Mod+N".action.spawn = [ "foot" "nvim" ];

      #settings
      "Mod+I".action.spawn = [ "noctalia" "msg" "settings open" ];

      #cheatsheet 
      "Mod+Shift+Slash".action.show-hotkey-overlay = { };

      # Lock / logout
      "Ctrl+Alt+L".action.spawn = [ "swaylock" ];
      "Ctrl+Alt+P".action.spawn = [ "wlogout" ];

      # Window management
      "Mod+Q".action.close-window = { };
      "Mod+M".action.quit = { };
      "Mod+V".action.toggle-window-floating = { };
      "Mod+F".action.fullscreen-window = { };
      "Mod+Shift+F".action.set-column-width = "50%";

      # Focus — vim style
      "Mod+H".action.focus-column-left = { };
      "Mod+L".action.focus-column-right = { };
      "Mod+K".action.focus-window-up = { };
      "Mod+J".action.focus-window-down = { };

      # Focus — arrow keys
      "Mod+Left".action.focus-column-left = { };
      "Mod+Right".action.focus-column-right = { };
      "Mod+Up".action.focus-window-up = { };
      "Mod+Down".action.focus-window-down = { };

      # Move windows/columns
      "Mod+Shift+H".action.move-column-left = { };
      "Mod+Shift+L".action.move-column-right = { };
      "Mod+Shift+K".action.move-window-up = { };
      "Mod+Shift+J".action.move-window-down = { };

      # Workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Shift+1".action.move-window-to-workspace = 1;
      "Mod+Shift+2".action.move-window-to-workspace = 2;
      "Mod+Shift+3".action.move-window-to-workspace = 3;
      "Mod+Shift+4".action.move-window-to-workspace = 4;
      "Mod+Shift+5".action.move-window-to-workspace = 5;
      "Mod+Shift+6".action.move-window-to-workspace = 6;
      "Mod+Shift+7".action.move-window-to-workspace = 7;
      "Mod+Shift+8".action.move-window-to-workspace = 8;
      "Mod+Shift+9".action.move-window-to-workspace = 9;

      # Screenshots
      "Print".action.screenshot = { };
      "Mod+Print".action.screenshot-screen = { };
      "Shift+Print".action.screenshot-window = { };

      # Volume / brightness
      "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
      "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
      "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
      "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "5%+" ];
      "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "5%-" ];

      # Media keys
      "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
      "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
      "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
    };
  };
}