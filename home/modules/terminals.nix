{ pkgs, ... }:
{
  #mostly using foot but kitty is installed too ! so yeah just edit it hoewever you want
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    font = {
      name = "monospace-mono";
      size = 12;
    };
    settings = {
      background_opacity = "0.35";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 10;
    };
  };

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
    };
  };
}