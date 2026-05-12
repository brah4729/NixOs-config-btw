{pkgs, ...}:
{
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
}