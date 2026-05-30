{ pkgs, ... }:
{
  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",

      "logo": {
        "source": "/etc/nixos/images/nixoswhite.png",
        "type": "kitty",
        "width": 17,
        "height": 10,
        "padding": {
        "top": 1,
        "left": 1,
        "right": 2
        }
    },
    "display": {
        "separator": "  →  ",
        "color": {
          "keys":      "38;2;189;147;249",
          "title":     "97",
          "separator": "38;2;255;184;108"
        }
      },

      "modules": [
        {
          "type": "title",
          "color": {
            "user": "38;2;255;184;108",
            "at":   "97",
            "host": "38;2;189;147;249"
          }
        },
        {
          "type": "separator",
          "string": "──────────────────────────"
        },
        { "type": "os",       "key": "󱄅  OS      " },
        { "type": "kernel",   "key": "  Kernel  " },
        { "type": "uptime",   "key": "  Uptime  " },
        { "type": "shell",    "key": "  Shell   " },
        { "type": "wm",       "key": "  WM      " },
        { "type": "terminal", "key": "  Term    " },
        {
          "type": "cpu",
          "key":  "  CPU     ",
          "showPeCoreCount": false
        },
        {
          "type": "gpu",
          "key":  "󰊴  GPU     ",
          "detectionMethod": "auto"
        },
        {
          "type": "memory",
          "key":  "󰍛  Memory  "
        },
        {
          "type": "disk",
          "key":  "󰋊  Disk    ",
          "folders": "/"
        }
      ]
    }
  '';
}