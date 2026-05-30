{pkgs, ...}:
{
  #maybe you want to change it since the color scheme is a bit weird but i like it so yeah if you want to change it just change the theme and the extraConfig and it will work by default or just install nixos via graphical installer if you want kde or something else but if you want to use rofi just enable it and it will work by default
    # Rofi - Custom launcher
    programs.rofi = {
        enable = true;
    package = pkgs.rofi;
    theme = "sidebar";
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