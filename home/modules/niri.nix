{ pkgs, ... }:
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
      { command = [ "swww-daemon" ]; }
      { command = [ "nm-applet" "--indicator" ]; }
      { command = [ "blueman-applet" ]; }
      { command = [ "hypridle" ]; }
    ];

    binds = with pkgs; {
      "Mod+Return".action.spawn = "kitty";
      "Mod+D".action.spawn = "rofi" ; # or your launcher of choice
      "Mod+Q".action.close-window = {};
      "Mod+Shift+E".action.quit = {};
    };
  };
}