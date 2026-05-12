{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
        grace = 5;
        no_fade_in = false;
      };

      background = [
        {
          path = "/etc/nixos/images/NixOs.jpg";
          blur_size = 4;
          blur_passes = 3;
          brightness = 0.5;
        }
      ];

      input-field = [
        {
          size = "300, 50";
          position = "0, -100";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          dots_size = 0.3;
          dots_spacing = 0.15;
          outer_color = "rgba(33ccffee)";
          inner_color = "rgba(1e1e2eff)";
          font_color = "rgba(cdd6f4ff)";
          fade_on_empty = true;
          placeholder_text = "🔒 Password...";
          check_color = "rgba(00ff99ee)";
          fail_color = "rgba(f38ba8ee)";
          fail_text = "Wrong password ($ATTEMPTS)";
          capslock_color = "rgba(f9e2afee)";
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo "<b>$(date +"%H:%M")</b>"'';
          color = "rgba(cdd6f4ff)";
          font_size = 72;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        {
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(cdd6f4cc)";
          font_size = 20;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
